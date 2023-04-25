// SPDX-License-Identifier: MIT
// Tells the Solidity compiler to compile only from v0.8.13 to v0.9.0
pragma solidity ^0.8.13;


// import "@openzeppelin/contracts/utils/Counters.sol";

import "./Counters.sol";

// This is just a simple example of a coin-like contract.
// It is not ERC20 compatible and cannot be expected to talk to other
// coin/token contracts.

contract Voting {
	using Counters for Counters.Counter;

    // Counters.Counter public _voterId;
    // Counters.Counter public _candidateId;
    Counters.Counter public _voterDetailId;

    address public votingOrganizer;


    //Tạo ứng viên cho cuộc bầu cử
    struct VoteDetail {
        uint256 voterDetailId;
        uint256 voteId;
        uint256 candidateId;
        uint256 voteQuantity;
        string createdDate;
        address _address;
    }

    event CreateVoteDetail(
        uint256 indexed voterDetailId,
        uint256 voteId,
        uint256 candidateId,
        uint256 voteQuantity,
        string createdDate,
        address _address
    );

    address[] public voteDetailAddress;
    mapping(address => VoteDetail) public voteDetails;

    //Tạo cử tri cho cuộc bầu cử
    struct VoterVote {
        uint256 id;
        uint256 voterId;
        uint256 voteDetailId;
        string votedTime;
        address _address;
    }

    event CreateVoterVote(
        uint256 indexed id,
        uint256 voterId,
        uint256 voteDetailId,
        string votedTime,
        address _address
    );

    address[] public voterVoteAddress;
    mapping(address => VoteDetail) public voterVoteList;

    ///CANDIDATE
    // struct Candidate {
    //     uint256 candidateId;
    //     string age;
    //     string name;
    //     string image;
    //     uint256 voteCount;
    //     address _address;
    //     string ipfs;
    // }

    // event CandidateCreate(
    //     uint256 indexed candidateId,
    //     string age,
    //     string name,
    //     string image,
    //     uint256 voteCount,
    //     address _address,
    //     string ipfs
    // );

    // address[] public candidateAddress;

    // mapping(address => Candidate) public candidates;

    // /////////////END
    // ////////////VOTERS////////////////////////

    // address[] public votedVoters;

    // address[] public votersAddress;
    // mapping(address => Voter) public voters;

    // struct Voter {
    //     uint256 voter_voterId;
    //     string voter_name;
    //     string voter_image;
    //     address voter_address;
    //     uint256 voter_allowed;
    //     bool voter_voted;
    //     uint256 voter_vote;
    //     string voter_ipfs;
    // }

    // event VoterCreated(
    //     uint256 indexed voter_voterId,
    //     string voter_name,
    //     string voter_image,
    //     address voter_address,
    //     uint256 voter_allowed,
    //     bool voter_voted,
    //     uint256 voter_vote,
    //     string voter_ipfs
    // );

    ////////////VOTERS////////////////////////

    constructor() {
        votingOrganizer = msg.sender;
    }

    //Tạo ứng viên cho cuộc bầu cử
    function setVoteDetail(
        address _address,
        uint256 _voteId,
        uint256 _candidateId,
        uint256 _voteQuantity,
        string memory _createdDate
    ) public {
        require(
            votingOrganizer == msg.sender,
            "You have no azuthorization to set Candidate"
        );

        _voterDetailId.increment();

        uint256 idNumber = _voterDetailId.current();

        VoteDetail storage voteDetail = voteDetails[_address];

        voteDetail.voteId = _voteId;
        voteDetail.voteQuantity = _voteQuantity;
        voteDetail.candidateId = _candidateId;
        voteDetail.voterDetailId = idNumber;
        voteDetail.createdDate = _createdDate;

        voteDetail._address = _address;

        voteDetailAddress.push(_address);

        emit CreateVoteDetail(
            voteDetail.voterDetailId,
            _voteId,
            _candidateId,
            _voteQuantity,
            _createdDate,
            voteDetail._address
        );
    }

    function getVoteDetailAddress() public view returns (address[] memory) {
        return voteDetailAddress;
    }

    function getVoteDetailData(address _address)
        public
        view
        returns (
            uint256,
            uint256,
            uint256,
            uint256,
            string memory,
            address
        )
    {
        return (
            voteDetails[_address].voterDetailId,
            voteDetails[_address].voteId,
            voteDetails[_address].candidateId,
            voteDetails[_address].voteQuantity,
            voteDetails[_address].createdDate,
            voteDetails[_address]._address
        );
    }



    // function setCandidate(
    //     address _address,
    //     string memory _age,
    //     string memory _name,
    //     string memory _image,
    //     string memory _ipfs
    // ) public {
    //     require(
    //         votingOrganizer == msg.sender,
    //         "You have no azuthorization to set Candidate"
    //     );

    //     _candidateId.increment();

    //     uint256 idNumber = _candidateId.current();

    //     Candidate storage candidate = candidates[_address];

    //     candidate.age = _age;
    //     candidate.name = _name;
    //     candidate.candidateId = idNumber;
    //     candidate.image = _image;
    //     candidate.voteCount = 0;
    //     candidate._address = _address;
    //     candidate.ipfs = _ipfs;

    //     candidateAddress.push(_address);

    //     emit CandidateCreate(
    //         candidate.candidateId,
    //         _age,
    //         _name,
    //         _image,
    //         candidate.voteCount,
    //         candidate._address,
    //         candidate.ipfs
    //     );
    // }

    // function getCandidate() public view returns (address[] memory) {
    //     return candidateAddress;
    // }

    // function getCandidateLength() public view returns (uint256) {
    //     return candidateAddress.length;
    // }

    // function getCandidateData(address _address)
    //     public
    //     view
    //     returns (
    //         string memory,
    //         string memory,
    //         uint256,
    //         string memory,
    //         uint256,
    //         string memory,
    //         address
    //     )
    // {
    //     return (
    //         candidates[_address].age,
    //         candidates[_address].name,
    //         candidates[_address].candidateId,
    //         candidates[_address].image,
    //         candidates[_address].voteCount,
    //         candidates[_address].ipfs,
    //         candidates[_address]._address
    //     );
    // }

    ///////////////////VOTER/////////////////

    // function voterRight(
    //     address _address,
    //     string memory _name,
    //     string memory _image,
    //     string memory _ipfs
    // ) public {
    //     require(
    //         votingOrganizer == msg.sender,
    //         "You have no right to provide authorization for vote"
    //     );

    //     _voterId.increment();

    //     uint256 idNumber = _voterId.current();

    //     Voter storage voter = voters[_address];

    //     require(voter.voter_allowed == 0);

    //     voter.voter_allowed = 1;
    //     voter.voter_name = _name;
    //     voter.voter_image = _image;
    //     voter.voter_address = _address;
    //     voter.voter_voterId = idNumber;
    //     voter.voter_vote = 1000;
    //     voter.voter_voted = false;
    //     voter.voter_ipfs = _ipfs;

    //     votersAddress.push(_address);

    //     emit VoterCreated(
    //         voter.voter_voterId,
    //         _name,
    //         _image,
    //         _address,
    //         voter.voter_allowed,
    //         voter.voter_voted,
    //         voter.voter_vote,
    //         voter.voter_ipfs
    //     );
    //     // }
    // }

    // function vote(address _candidateAddress, uint256 _candidateVoteId)
    //     external
    // {
    //     Voter storage voter = voters[msg.sender];

    //     require(!voter.voter_voted, "You have already voted");
    //     require(voter.voter_allowed != 0, "You have no right to vote");

    //     voter.voter_voted = true;
    //     voter.voter_vote = _candidateVoteId;

    //     votedVoters.push(msg.sender);

    //     candidates[_candidateAddress].voteCount += voter.voter_allowed;
    // }

    // function getVoterLength() public view returns (uint256) {
    //     return votersAddress.length;
    // }

    // function getVoterData(address _address)
    //     public
    //     view
    //     returns (
    //         uint256,
    //         string memory,
    //         string memory,
    //         address,
    //         string memory,
    //         uint256,
    //         bool
    //     )
    // {
    //     return (
    //         voters[_address].voter_voterId,
    //         voters[_address].voter_name,
    //         voters[_address].voter_image,
    //         voters[_address].voter_address,
    //         voters[_address].voter_ipfs,
    //         voters[_address].voter_allowed,
    //         voters[_address].voter_voted
    //     );
    // }

    // function getVotedVotersList() public view returns (address[] memory) {
    //     return votedVoters;
    // }

    // function getVoterList() public view returns (address[] memory) {
    //     return votersAddress;
    // }
}
