"use client";

import Image from "next/image";
import { ConnectButton } from "@rainbow-me/rainbowkit";
import { useAccount,useReadContract,useWriteContract } from "wagmi";
import { useState,useEffect } from "react";
import {abi,contactaddress} from './abi';
import { MainTodo } from "@/components/main-todo";
import { type Task } from "@/components/main-todo"; 

export default function Home() {
  const [tasks, setTasks] = useState([]);
  const accoutnt = useAccount();
  const result = useReadContract({
    abi,
    address: contactaddress,
    functionName: 'getUserTasks',
    account: accoutnt.address,
  })
  useEffect(
    () => {
      // console.log(result.data);
    },
    [accoutnt]
  );

  return (
    <main>
      <MainTodo tasks={result.data as Task[]} />
    </main>
  );
}
