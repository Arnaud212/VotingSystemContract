// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.13;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Voting is Ownable {
    
    //Init struct
    struct Voter {
        bool isRegistered;
        bool hasVoted;
        uint votedProposalId;
    }
    
    struct Proposal {
        string description;
        uint voteCount;
    }
    
    //Init different states 
    enum WorkflowStatus {
        RegisteringVoters,
        ProposalsRegistrationsStarted,
        ProposalsRegistrationsEnded,
        VotingSessionStarted,
        VotingSessionEnded,
        VotesTallied
    }
    
    //Define events
    event VoterRegistered(address voterAddress); 
    event WorkflowStatusChange(WorkflowStatus previousStatus, WorkflowStatus newStatus);
    event ProposalRegistered(uint proposalId);
    event Voted (address voter, uint proposalId);
    event ProposalsRegistrationsStarted();
    event ProposalsRegistrationsEnded();
    event VotingSessionStarted();
    event VotingSessionEnded();
    event VotesTallied();

    //Declaration of global variables
    mapping(address => Voter) public whitelist; //Mapping of voters
    Proposal[] public proposals; //Array of proposals
    WorkflowStatus status; //Follow the step
    uint winningProposalId; //Winning ID

    //Functions

    //Adding voters to the whitelist
    function AddingVoters(address _address) public onlyOwner {
        WorkflowStatus oldStatus = status;
        status = WorkflowStatus.RegisteringVoters;
        require(!whitelist[_address].isRegistered, "This address is already whitelist.");
        
        whitelist[_address].isRegistered = true;
        
        emit VoterRegistered(_address);
        emit WorkflowStatusChange(oldStatus, status);
    }

    //Start of proposal registration
    function startProposalsRegistration() public onlyOwner {
        WorkflowStatus oldStatus = status;
        status = WorkflowStatus.ProposalsRegistrationsStarted;
        
        emit ProposalsRegistrationsStarted();
        emit WorkflowStatusChange(oldStatus, status);
    }

    //Adding Proposals
    function AddingProposals(string memory _description) public {
        require(status == WorkflowStatus.ProposalsRegistrationsStarted, "This is not the proposals registration");
        require(whitelist[msg.sender].isRegistered == true, "You are not whitelist");
        
        proposals.push(Proposal({description: _description, voteCount: 0}));
        uint proposalId = proposals.length;
        
        emit ProposalRegistered(proposalId);
    }    

    //End of proposal registration
    function EndProposalsRegistrations() public onlyOwner {
        WorkflowStatus oldStatus = status;
        status = WorkflowStatus.ProposalsRegistrationsEnded;
        
        emit ProposalsRegistrationsEnded();
        emit WorkflowStatusChange(oldStatus, status);
    }

    //Start of the voting session
    function StartVoting() public onlyOwner {
        WorkflowStatus oldStatus = status;
        status = WorkflowStatus.VotingSessionStarted;
        
        emit VotingSessionStarted();
        emit WorkflowStatusChange(oldStatus, status);
    }
    
    //Time to vote
    function AddingVotes(uint _proposalId) public {
        require(status == WorkflowStatus.VotingSessionStarted, "The is not the voting session.");
        require(whitelist[msg.sender].isRegistered == true, "You are not whitelist.");
        require(whitelist[msg.sender].hasVoted == false, "You have already voted");
        
       
        proposals[_proposalId].voteCount += 1;
        whitelist[msg.sender].hasVoted = true;
        whitelist[msg.sender].votedProposalId = _proposalId;
        
        emit Voted(msg.sender, _proposalId);
    }

    //End of the voting session
    function EndVoting() public onlyOwner {
        WorkflowStatus oldStatus = status;
        status = WorkflowStatus.VotingSessionEnded;
        
        emit VotingSessionEnded();
        emit WorkflowStatusChange(oldStatus, status);
    }

    //Number of votes counted
    function FindWinner() public onlyOwner {
        WorkflowStatus oldStatus = status;
        status = WorkflowStatus.VotesTallied;
        
        uint winningVoteCount = 0;
        for (uint i; i < proposals.length; i++) {
            if (proposals[i].voteCount > winningVoteCount) {
                winningVoteCount = proposals[i].voteCount;
                winningProposalId = i;
            }
        }
        
        emit VotesTallied();
        emit WorkflowStatusChange(oldStatus, status);
    }

    //Show the winner's proposal 
    function ShowWinnerProposal() public view returns (string memory _description) {
        _description = proposals[winningProposalId].description;
    }
}
