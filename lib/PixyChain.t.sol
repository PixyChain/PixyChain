// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "forge-std/Test.sol";
import "../src/PixyChain.sol";

contract PixyChainTest is Test {
    PixyChain pixy;
    address donor = address(0x1);
    address student = address(0x2);
    address reviewer = address(0x3);

    function setUp() public {
        pixy = new PixyChain();

        // Ensure donor has funds
        vm.deal(donor, 0.01 ether);
        vm.deal(student, 0.01 ether);
        vm.deal(reviewer, 0.01 ether);
    }

    function testFundScholarship() public {
        vm.prank(donor);
        pixy.fundScholarship{value: 0.01 ether}("AI Scholarship", 0.01 ether);

        (string memory name, address donorAddr, uint amount, , bool disbursed) = pixy.scholarships(0);
        
        assertEq(name, "AI Scholarship");
        assertEq(donorAddr, donor);
        assertEq(amount, 0.01 ether);
        assertFalse(disbursed);
    }

    function testApplyForScholarship() public {
        vm.prank(donor);
        pixy.fundScholarship{value: 0.01 ether}("AI Scholarship", 0.01 ether);

        vm.prank(student);
        pixy.applyForScholarship("QmExampleIPFSHash", 0);

        (address applicant, string memory ipfsHash, bool approved, , , uint scholarshipId) = pixy.applications(0);
        
        assertEq(applicant, student);
        assertEq(ipfsHash, "QmExampleIPFSHash");
        assertFalse(approved);
        assertEq(scholarshipId, 0);
    }

    function testReviewAndApproveApplication() public {
        vm.prank(donor);
        pixy.fundScholarship{value: 0.01 ether}("AI Scholarship", 0.01 ether);

        vm.prank(student);
        pixy.applyForScholarship("QmExampleIPFSHash", 0);

        // Add reviewer before reviewing
        vm.prank(address(this));
        pixy.addReviewer(reviewer, 9);

        vm.prank(reviewer);
        pixy.quadraticVote(0, 8);

        vm.prank(reviewer);
        pixy.approveApplication(0);

        (, , bool approved, , , uint scholarshipId) = pixy.applications(0);
        (, , , address recipient, ) = pixy.scholarships(0);

        assertTrue(approved);
        assertEq(recipient, student);
        assertEq(scholarshipId, 0);
    }

    function testDisburseFunds() public {
        vm.prank(donor);
        pixy.fundScholarship{value: 0.01 ether}("AI Scholarship", 0.01 ether);

        vm.prank(student);
        pixy.applyForScholarship("QmExampleIPFSHash", 0);

        vm.prank(address(this));
        pixy.addReviewer(reviewer, 9);

        vm.prank(reviewer);
        pixy.quadraticVote(0, 8);

        vm.prank(reviewer);
        pixy.approveApplication(0);

        // Ensure recipient is correct
        (, , , address recipient, ) = pixy.scholarships(0);
        assertEq(recipient, student);

        // Student disburses funds
        vm.prank(student);
        pixy.disburseFunds(0);

        (, , , , bool disbursed) = pixy.scholarships(0);
        assertTrue(disbursed);
    }
}
