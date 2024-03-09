// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract ToDoList {
    struct Task {
        uint id;
        address owner;
        string content;
        bool completed;
    }

    mapping(address => Task[]) public userTasks;

    event TaskCreated(address indexed user, uint id, string content, bool completed);
    event TaskCompleted(address indexed user, uint id, bool completed);
    event TaskCleared(address indexed user);
    event TaskDeleted(address indexed user, uint id);

    modifier onlyTaskOwner(uint _taskId) {
        require(msg.sender == userTasks[msg.sender][_taskId].owner, "Only the task owner can perform this action");
        _;
    }

    function createTask(string memory _content) public {
        uint taskId = userTasks[msg.sender].length;
        userTasks[msg.sender].push(Task(taskId, msg.sender, _content, false));
        emit TaskCreated(msg.sender, taskId, _content, false);
    }

    function completeTask(uint _taskId) public onlyTaskOwner(_taskId) {
        userTasks[msg.sender][_taskId].completed = !userTasks[msg.sender][_taskId].completed;
        emit TaskCompleted(msg.sender, _taskId, true);
    }

    function clearCompletedTasks() public {
        Task[] storage tasks = userTasks[msg.sender];
        for (uint i = 0; i < tasks.length; i++) {
            if (tasks[i].completed) {
                delete tasks[i];
                for (uint j = i; j < tasks.length - 1; j++) {
                    tasks[j] = tasks[j + 1];
                }
                tasks.pop();
                i--;
            }
        }
        emit TaskCleared(msg.sender);
    }

    function deleteTask(uint _taskId) public onlyTaskOwner(_taskId) {
        require(_taskId < userTasks[msg.sender].length, "Task does not exist");
        delete userTasks[msg.sender][_taskId];
        for (uint i = _taskId; i < userTasks[msg.sender].length - 1; i++) {
            userTasks[msg.sender][i] = userTasks[msg.sender][i + 1];
        }
        userTasks[msg.sender].pop();
        emit TaskDeleted(msg.sender, _taskId);
    }
    function getUserTasks() public view returns (Task[] memory) {
    return userTasks[msg.sender];
    }

}
