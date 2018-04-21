pragma solidity ^0.4.18;

contract DelegationDX
{

    struct Dta 
    {

        string tickr;
        string ctype;
        uint256 positive;
        uint256 negative;
        string result;

    }


  modifier only_admin()
  {

    if(msg.sender != admin) throw;
       _;

  }

  uint256 constant VOTE = 10000;
  byte constant POS = 0x01;
  byte constant NEG = 0x01;
  string constant NA = "NA";

  mapping(string => Dta) delegate; 
  mapping(address => Votee) voter; 

  function delegationReward() internal constant returns (uint256) 
  {

    uint256 wager = balances[tx.origin];
    require(wager >= VOTE);
    uint256 reward = wager/VOTE;
    balances[tx.origin] += reward;

    return wager;

  }

  function delegationCreate(string project,string ticker,string ctype) only_admin
  {

    Dta memory input = Dta({tickr: ticker, ctype: ctype, negative: 0 , positive: 0, result: NA}); 
    delegate[project] = input; 

  }

  function delegationResults() public
  {


   

  }

  function voteSubmission(string name, string project, byte OPTION) public
  {

    string prev;
    require(OPTION == NEG || OPTION == POS);
    Votee storage x = voter[msg.sender];
    if(x.delegation_count == 0){voteRegister();}
    
    for(y = 0 ; y < x.delegates.length ; y++)
    {

        prev = x.delegates[y];
        
        if(keccak256(prev) == keccak256(project)){revert();}
        else if(keccak256(prev) != keccak256(project)){continue;}

    }

    Dta storage output = delegate[project];
    require(output.result == NA);
    uint256 voting_weight = delegationReward();

    if(OPTION == POS){output.positive += voting_weight; x.pos_vote  += voting_weight;} 
    else if(OPTION == NEG){output.negative += voting_weight; x.neg_vote  += voting_weight;} 


  }


  function voteCount() only_admin
  {




  }
  
  }
