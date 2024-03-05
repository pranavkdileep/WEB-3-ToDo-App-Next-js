'use client';
import Image from "next/image";
import { MainComponent } from "@/components/main-component";
import { useEffect,useState } from "react";
import {ethers} from 'ethers';
import {contractAddress,abi} from '../Backend/config';

export default function Home() {
  const [tasks,setTasks] = useState([]);
  useEffect (
    () => {
      const connecttometamask = async () => {
        try{
          if(window.ethereum)
          {
            const provider = new ethers.BrowserProvider(window.ethereum);
            const signer = provider.getSigner();
            const address = await (await signer).getAddress();
            const contractinstance = await new ethers.Contract(contractAddress,abi,provider);
            const task = await contractinstance.getallTasks();
            setTasks(task);
            console.log(task[0][2]);
          }
          else
          {
            console.log("Install Metamask");
          }
        }
        catch(err)
        {
          console.log(err);
        }
      }
      connecttometamask();
    }
  ),[];
  return (
    <main>
     {
      tasks.map((task) => {
        return (
          <div key={task[0]}>
            <p>{task[1]}</p>
            <p>{task[2]}</p>
          </div>
        );
      })
     }
    </main>
  );
}
