VotingSystemContract

This project contains a Solidity smart contract for a simple and transparent voting system, leveraging OpenZeppelin's Ownable contract for ownership management.

Features

Voter Registration: Only the owner can register voters.
Proposal Submission: Registered voters can submit proposals.
Voting Process: Registered voters can vote on proposals.
Winner Declaration: Tallies votes and declares the winning proposal.
Workflow

Register Voters: Owner adds voters to the whitelist.
Submit Proposals: Owner manages the proposal submission period.
Voting Session: Owner starts and ends the voting period.
Tally Votes: Owner tallies votes and announces the winner.
Events

VoterRegistered(address voterAddress)
WorkflowStatusChange(WorkflowStatus previousStatus, WorkflowStatus newStatus)
ProposalRegistered(uint proposalId)
Voted(address voter, uint proposalId)
ProposalsRegistrationsStarted()
ProposalsRegistrationsEnded()
VotingSessionStarted()
VotingSessionEnded()
VotesTallied()
Key Functions

AddingVoters(address _address): Adds a voter.
startProposalsRegistration(): Starts proposal registration.
AddingProposals(string memory _description): Adds a proposal.
EndProposalsRegistrations(): Ends proposal registration.
StartVoting(): Starts the voting session.
AddingVotes(uint _proposalId): Casts a vote.
EndVoting(): Ends the voting session.
FindWinner(): Tallies votes and determines the winner.
ShowWinnerProposal(): Displays the winning proposal description.
