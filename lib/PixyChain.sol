Christabel, [3/21/2025 2:03 PM]
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract PixyChain {
    struct Application {
        address student;
        string ipfsHash;
        bool approved;
        uint totalScore;
        uint reviewCount;
        uint scholarshipId;
    }

    struct Scholarship {
        string name;
        address donor;
        uint amount;
        address recipient;
        bool disbursed;
    }

    struct Job {
        string title;
        string description;
        address reviewer;
        bool filled;
    }

    struct JobApplication {
        address applicant;
        string ipfsHash;
        bool approved;
    }

    struct CommunityGrant {
        string projectName;
        address donor;
        uint amount;
        address recipient;
        bool disbursed;
    }

    struct Reviewer {
        bool isAuthorized;
        uint reputation;
    }

    mapping(uint => Application) public applications;
    mapping(uint => Scholarship) public scholarships;
    mapping(uint => Job) public jobs;
    mapping(uint => JobApplication) public jobApplications;
    mapping(uint => CommunityGrant) public communityGrants;
    mapping(address => Reviewer) public reviewers;
    uint public applicationCount;
    uint public scholarshipCount;
    uint public jobCount;
    uint public jobApplicationCount;
    uint public grantCount;

    // **Events**
    event ScholarshipApplied(address indexed student, uint applicationId, string ipfsHash);
    event ScholarshipFunded(address indexed donor, uint scholarshipId, string name, uint amount);
    event ApplicationReviewed(uint applicationId, address reviewer, uint score);
    event ApplicationApproved(uint applicationId, uint scholarshipId, address recipient);
    event ScholarshipDisbursed(uint scholarshipId, address recipient, uint amount);
    event JobPosted(address indexed reviewer, uint jobId, string title);
    event JobApplied(address indexed applicant, uint jobId, uint applicationId);
    event JobApplicationApproved(uint jobAppId, uint jobId, address applicant);
    event GrantFunded(address indexed donor, uint grantId, string projectName, uint amount);
    event GrantApplied(address indexed applicant, uint grantId, uint applicationId);
    event GrantApplicationReviewed(uint applicationId, address reviewer, uint score);
    event GrantApplicationApproved(uint applicationId, uint grantId, address recipient);
    event GrantDisbursed(uint grantId, address recipient, uint amount);

    modifier onlyReviewer() {
        require(reviewers[msg.sender].isAuthorized, "Not an authorized reviewer");
        _;
    }

    function addReviewer(address _reviewer, uint _reputation) public {
        reviewers[_reviewer] = Reviewer(true, _reputation);
    }
    
    
    function fundScholarship(string memory _name, uint _amount) public payable {
        require(msg.value == _amount, "Insufficient funds");
        scholarships[scholarshipCount] = Scholarship(_name, msg.sender, _amount, address(0), false);
        emit ScholarshipFunded(msg.sender, scholarshipCount, _name, _amount);
        scholarshipCount++;
    }

    function applyForScholarship(string memory _ipfsHash, uint _scholarshipId) public {
        applications[applicationCount] = Application(msg.sender, _ipfsHash, false, 0, 0, _scholarshipId);
        emit ScholarshipApplied(msg.sender, applicationCount, _ipfsHash);
        applicationCount++;
    }

    function quadraticVote(uint _appId, uint _score) public onlyReviewer {
        require(_score >= 1 && _score <= 10, "Invalid score");
        require(!applications[_appId].approved, "Application already approved");
        
        uint weight = sqrt(reviewers[msg.sender].reputation);
        applications[_appId].totalScore += _score * weight;
        applications[_appId].reviewCount += weight;
        
        emit ApplicationReviewed(_appId, msg.sender, _score);
    }

    function approveApplication(uint _appId) public onlyReviewer {
        require(applications[_appId].reviewCount >= 3, "Not enough reviews");
        require(applications[_appId].totalScore /

Christabel, [3/21/2025 2:03 PM]
ap

Christabel, [3/21/2025 2:03 PM]
plications[_appId].reviewCount >= 7, "Low average score");
        
        applications[_appId].approved = true;
        scholarships[applications[_appId].scholarshipId].recipient = applications[_appId].student;
        emit ApplicationApproved(_appId, applications[_appId].scholarshipId, applications[_appId].student);
    }
    function disburseFunds(uint _scholarshipId) public {
        require(scholarships[_scholarshipId].recipient == msg.sender, "Not authorized");
        require(!scholarships[_scholarshipId].disbursed, "Already disbursed");

        payable(msg.sender).transfer(scholarships[_scholarshipId].amount);
        scholarships[_scholarshipId].disbursed = true;
        emit ScholarshipDisbursed(_scholarshipId, msg.sender, scholarships[_scholarshipId].amount);
    }

    function postJob(string memory _title, string memory _description) public onlyReviewer {
        jobs[jobCount] = Job(_title, _description, msg.sender, false);
        emit JobPosted(msg.sender, jobCount, _title);
        jobCount++;
    }
     function applyForJob(uint _jobId, string memory _ipfsHash) public {
        require(!jobs[_jobId].filled, "Job already filled");
        jobApplications[jobApplicationCount] = JobApplication(msg.sender, _ipfsHash, false);
        emit JobApplied(msg.sender, _jobId, jobApplicationCount);
        jobApplicationCount++;
    }
    function approveJobApplication(uint _jobAppId, uint _jobId) public onlyReviewer {
    require(jobApplications[_jobAppId].approved == false, "Application already approved");
    require(jobs[_jobId].filled == false, "Job already filled");
    
    jobApplications[_jobAppId].approved = true;
    jobs[_jobId].filled = true;
    
    emit JobApplicationApproved(_jobAppId, _jobId, jobApplications[_jobAppId].applicant);
}

    
     function fundCommunityGrant(string memory _projectName, uint _amount) public payable {
        require(msg.value == _amount, "Insufficient funds");
        communityGrants[grantCount] = CommunityGrant(_projectName, msg.sender, _amount, address(0), false);
        emit GrantFunded(msg.sender, grantCount, _projectName, _amount);
        grantCount++;
    }

    function applyForGrant(uint _grantId, string memory _ipfsHash) public {
        applications[applicationCount] = Application(msg.sender, _ipfsHash, false, 0, 0, _grantId);
        emit GrantApplied(msg.sender, _grantId, applicationCount);
        applicationCount++;
    }

    function quadraticVoteGrant(uint _appId, uint _score) public onlyReviewer {
        require(_score >= 1 && _score <= 10, "Invalid score");
        require(!applications[_appId].approved, "Application already approved");
        
        uint weight = sqrt(reviewers[msg.sender].reputation);
        applications[_appId].totalScore += _score * weight;
        applications[_appId].reviewCount += weight;
        
        emit GrantApplicationReviewed(_appId, msg.sender, _score);
    }

    function approveGrantApplication(uint _appId) public onlyReviewer {
        require(applications[_appId].reviewCount >= 3, "Not enough reviews");
        require(applications[_appId].totalScore / applications[_appId].reviewCount >= 7, "Low average score");
        
        applications[_appId].approved = true;
        communityGrants[applications[_appId].scholarshipId].recipient = applications[_appId].student;
        emit GrantApplicationApproved(_appId, applications[_appId].scholarshipId, applications[_appId].student);
    }
   
    function disburseGrantFunds(uint _grantId) public {
        require(communityGrants[_grantId].recipient == msg.sender, "Not authorized");
        require(!communityGrants[_grantId].disbursed, "Already disbursed");

        payable(msg.sender).transfer(communityGrants[_grantId].amount);
        communityGrants[_grantId].disbursed = true;
        emit GrantDisbursed(_grantId, msg.sender, communityGrants[_grantId].amount);
    }


    function sqrt(uint x) internal pure returns (uint) {
        uint z = (x + 1) / 2;
        uint y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }

Christabel, [3/21/2025 2:03 PM]
return y;
    }
}
