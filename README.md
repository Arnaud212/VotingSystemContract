# VoteSystem

This project contains a Solidity smart contract for a simple and transparent voting system, designed for a small organization. The contract is managed by the owner and allows for voter registration, proposal submission, voting, and tallying of votes.

## Features

- **Voter Registration**: Only the owner can register voters.
- **Proposal Submission**: Registered voters can submit proposals.
- **Voting Process**: Registered voters can vote on proposals.
- **Winner Declaration**: Tallies votes and declares the winning proposal.

## Workflow

1. **Register Voters**: Owner adds voters to the whitelist.
2. **Submit Proposals**: Registered voters can submit proposals during the proposal registration period.
3. **Voting Session**: Registered voters can vote during the voting period.
4. **Tally Votes**: Owner tallies the votes and announces the winner.

## Events

- `VoterRegistered(address voterAddress)`: Emitted when a voter is registered.
- `WorkflowStatusChange(WorkflowStatus previousStatus, WorkflowStatus newStatus)`: Emitted when the workflow status changes.
- `ProposalRegistered(uint proposalId)`: Emitted when a proposal is registered.
- `Voted(address voter, uint proposalId)`: Emitted when a vote is cast.

## Key Functions

- `addVoter(address _addr)`: Adds a voter during the registration phase.
- `addProposal(string memory _desc)`: Adds a proposal during the proposal registration phase.
- `setVote(uint _id)`: Casts a vote during the voting session.
- `startProposalsRegistering()`: Starts the proposal registration phase.
- `endProposalsRegistering()`: Ends the proposal registration phase.
- `startVotingSession()`: Starts the voting session.
- `endVotingSession()`: Ends the voting session.
- `tallyVotes()`: Tallies votes and determines the winning proposal.
- `getVoter(address _addr)`: Retrieves voter information.
- `getOneProposal(uint _id)`: Retrieves a specific proposal.
- `getWinner()`: Retrieves the winning proposal after votes are tallied.
