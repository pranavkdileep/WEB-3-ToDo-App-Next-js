"use client";

import React, { useState, useEffect } from 'react';

import * as Config from '@/Backend/config';
import { MainComponent } from '@/components/main-component';
import Web3 from 'web3';




function App() {
  const [tasks, setTasks] = useState([]);
  const [web3, setWeb3] = useState(null);
  const [contract, setContract] = useState(null);
  const [accounts, setAccounts] = useState([]);

  useEffect(() => {
    if(window.ethereum){
      const web3 = new Web3(window.ethereum)
      setWeb3(web3)
      const accounts = web3.eth.requestAccounts()
      setAccounts(accounts)
      console.log(accounts)
      const contract = new web3.eth.Contract(Config.abi, Config.address)
      setContract(contract)
    }

    const getTasks = async () => {
      const tasks = await contract.methods.getUserTasks().call()
      setTasks(tasks)
    }
    getTasks();
    
  }, []);

  return (
    <main>
      <MainComponent tasks={tasks} />
    </main>
  );
}

export default App;