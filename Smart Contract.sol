pragma solidity >=0.4.22 <0.7.0;
pragma experimental ABIEncoderV2;

//Modify the given address by your accounts to run this code
//You can also write a helper function to set the Addresses 

contract A{
enum Stages{
        start_A,
        end_A
    }
    
modifier atStage(Stages _stage) {
        require(
            stage == _stage,
            "Function cannot be called at this time."
        );
        _;
    }


function nextStage() internal {
        stage = Stages(uint(stage) + 1);
    }
    
Stages public stage;
    
    constructor() public {                  
	stage = Stages.start_A;        
    }  


     modifier A_Head() {
         require(
            msg.sender == 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c,
            "Sender not authorized."
        );
        _;
     }
     
     
     modifier A_agent {
         require(
            msg.sender == 0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C,
            "Sender not authorized."
        );
        _;
     }
     
       modifier A_Department {
      require((msg.sender == 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c) || (msg.sender == 0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C ));
      _;
   }
           modifier Judge_only {
         require(
            msg.sender == 0xa0bB92dBdC2CB660655a9ac7fbC96d0Af388F489,
            "Sender not authorized."
        );
        _;
     }
     
        modifier B_Department {
      require((msg.sender == 0x4B0897b0513fdC7C541B6d9D7E929C4e5364D2dB) || (msg.sender == 0x583031D1113aD414F02576BD6afaBfb302140225 ));
      _;
   }
    uint count=0;
    mapping(uint => string) public A_map;
   
   
   event A_uploaded(address a,bytes32 s1 , string s2);
   
    function Upload_work_ipfshash_byA(string memory k) public
    A_Department
    atStage(Stages.start_A)
    returns (string memory){
        count++;
        A_map[count]=k;
        emit A_uploaded(msg.sender, "has uploaded" ,k);
        return A_map[count];
        }
        
    uint n=0;
    
    function getstring1()
    public 
    atStage(Stages.end_A)
    B_Department
    returns(string memory) {
      n++;
      return A_map[n]; }
      
        function getstring2()
    public 
    Judge_only
    returns(string memory) {
      n++;
      return A_map[n]; }
      
      
     function reset_n_to_get_string_again()public{
     n=0;
                                            }
    
 //view here means that B can only read it and not modify it
   event A_work_ended (string s); //To notify B that work of A has ended
        
    
    function End_work() public
    A_Head
    atStage(Stages.start_A)
    {
        nextStage();
        emit A_work_ended("Work of Department A has ended. Department B, start your work! ");
        
    }
    
   
}


contract Judge_A is A{
    
    
   A private o;
   
   constructor() public {
      o = new A();
   }  
   
        modifier Judge_only {
         require(
            msg.sender == 0xa0bB92dBdC2CB660655a9ac7fbC96d0Af388F489,
            "Sender not authorized."
        );
        _;
     }
   
}   


contract B is A{
   
   A private c;
   
   constructor() public {
      c = new A();
   }  


  modifier B_agent {
         require(
            msg.sender == 0x4B0897b0513fdC7C541B6d9D7E929C4e5364D2dB,
            "Sender not authorized."
        );
        _;
     }

     modifier B_Head() {
         require(
            msg.sender == 0x583031D1113aD414F02576BD6afaBfb302140225,
            "Sender not authorized."
        );
        _;
     }
   
   
uint l=0;
mapping(uint => string) internal B_map;
    
event B_uploaded(bytes32 s1 , string s2); //strings uploaded by B is visible to all

function Upload_work_ipfshash_byB(string memory k) public
    B_Department
    atStage(Stages.end_A)
    returns (string memory){
        l++;
        B_map[l]=k;
        emit B_uploaded("Department B has uploaded", k);
        return B_map[l];
        }

event request(address msg_from, bytes30 m, string message);

//Emit an event
// emit Deposit(msg.sender, _id, msg.value);

        
function requestorder_to_C
    (string memory s)
    public
    B_Department
  {
        emit request(msg.sender,"B is requesting about-", s);
         
   }
}


contract C{
     modifier C_agent {
         require(
            msg.sender == 0xdD870fA1b7C4700F2BD7f44238821C26f7392148,
            "Sender not authorized."
        );
        _;
     }

     modifier C_Head() {
         require(
            msg.sender == 0x7281886a44bCe7e594D4B61C4BFD7A04D5370b25,
            "Sender not authorized."
        );
        _;
     }
         mapping(uint => string) internal C_map;
        event file_sent (address msg_from, string ipfs);
        uint b=0;
      function Send_file_to_B_and_Upload_to_IPFS(string memory k) public
    returns (string memory){
        b++;
        C_map[b]=k;
        emit file_sent(msg.sender, k);
        return C_map[b];
        }
    
}


