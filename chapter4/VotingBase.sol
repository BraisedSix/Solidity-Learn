// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// 基础投票合约
contract VotingBase {
    uint256 public totalVotes;
    string public constant BASE_NAME = "VotingBase";

    constructor(uint256 _initialVotes) {
        totalVotes = _initialVotes;
    }

    function vote() public virtual {
        totalVotes++;
    }

    function getContractName() public virtual returns (string memory) {
        return BASE_NAME;
    }
}

// 候选人管理合约
contract CandidateManager {
    string[] public candidates;

    function addCandidate(string memory _name) public virtual {
        candidates.push(_name);
    }

    function getCandidateCount() public view returns (uint256) {
        return candidates.length;
    }
}

// 选举合约，继承 VotingBase 和 CandidateManager
contract Election is VotingBase, CandidateManager {
    string public constant ELECTION_NAME = "Election";
    mapping(address => bool) public hasVoted;

    constructor(uint256 _initialVotes) VotingBase(_initialVotes) {}

    // 重写 vote 函数，添加防重复投票逻辑
    function vote() public override {
        require(!hasVoted[msg.sender], "Already voted");
        hasVoted[msg.sender] = true;
        totalVotes++;
    }

    // 重写 getContractName 函数
    function getContractName() public pure override returns (string memory) {
        return ELECTION_NAME;
    }

    // 重写 addCandidate 函数，添加长度限制
    function addCandidate(string memory _name) public override {
        require(bytes(_name).length > 0, "Candidate name cannot be empty");
        candidates.push(_name);
    }

    // 重载 getContractName，接受参数
    function getContractName(
        string memory prefix
    ) public pure returns (string memory) {
        return string(abi.encodePacked(prefix, ELECTION_NAME));
    }
}
