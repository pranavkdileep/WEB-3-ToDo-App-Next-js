// SPDX-License-Identifier: GPL-3.0
pragma solidity = 0.8.24;

contract Todo {
    address public user;
    constructor() {
        user = msg.sender;
    }
    struct Task {
        uint256 id;
        string content;
        bool completed;
    }
    Task[] public tasks;
    mapping(uint256 => address) public taskToOwner;
    modifier onlyOwner(uint256 _taskId) {
        require(msg.sender == taskToOwner[_taskId]);
        _;
    }

    function createTask(string memory content) public {
        tasks.push(Task(tasks.length, content, false));
        taskToOwner[tasks.length] = msg.sender;
    }
    function toggleCompleted(uint256 _taskId) public onlyOwner(_taskId) {
        tasks[_taskId].completed = !tasks[_taskId].completed;
    }
    function getAllTasks() public view returns (Task[] memory) {
        uint256 length = tasks.length;
        uint256 count = 0;
        Task[] memory tasks_ = new Task[](length);
        for (uint256 i = 0; i < length; i++) {
            if (taskToOwner[i] == msg.sender) {
                tasks_[count] = tasks[i];
                count++;
            }
        }
        Task[] memory tasks__ = new Task[](count);
        for (uint256 i = 0; i < count; i++) {
            tasks__[i] = tasks_[i];
        }
        return tasks;
    }

        
    
}