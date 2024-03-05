// SPDX-License-Identifier: GPL-3.0
pragma solidity = 0.8.24;

contract Todo {
    address public user;
    constructor() {
        user = msg.sender;
    }
    struct Task {
        uint id;
        string content;
        bool completed;
    }
    Task[] public tasks;
    
    modifier onlyOwner() {
        require(msg.sender == user, "You are not the owner");
        _;
    }
    function createTask(string memory _content) public onlyOwner {
        tasks.push(Task(tasks.length, _content, false));
    }
    function toggleCompleted(uint _id) public onlyOwner {
        tasks[_id].completed = !tasks[_id].completed;
    }
    function getallTasks() public view returns(Task[] memory) {
        return tasks;
    }
    function clearAllTasks() public onlyOwner {
        delete tasks;
    }
    function deleteTask(uint _id) public onlyOwner {
        delete tasks[_id];
    }
}