import { apiurl,contractAddress,abi,privateKey } from "./config";
import { ethers } from "ethers";

export const addAtask = async (task) => {
    try{
        const provider = new ethers.JsonRpcProvider(apiurl);
        const wallet = new ethers.Wallet(privateKey,provider);
        const contractinstance = new ethers.Contract(contractAddress,abi,wallet);
        const transaction = await contractinstance.createTask(task);
        const tx = await transaction.wait();
        console.log(tx);
    }
    catch(err){
        console.log(err);
    }
}