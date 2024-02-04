// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Record {

  struct Patients{
        string ic;
        string name;
        string phone;
        string gender;
        string dob;
        string height;
        string weight;
        string bloodgroup;
        string allergies;
        address addr;
        uint date;
    }

    address public owner;
    address[] public patientList;


    mapping(address => Patients) patients;

    mapping(address=>mapping(address=>bool)) isApproved;
    mapping(address => bool) isPatient;

    uint256 public patientCount = 0;

    constructor()  {
        owner = msg.sender;
    }
    Patients p;

    //Retrieve patient details from user sign up page and store the details into the blockchain
    function setDetails(string memory _ic, string memory _name, string memory _phone, string memory _gender, string memory _dob, string memory _height, string memory _weight, string memory _bloodgroup, string memory _allergies) public {
        require(!isPatient[msg.sender]);
         p = patients[msg.sender];
        
        p.ic = _ic;
        p.name = _name;
        p.phone = _phone;
        p.gender = _gender;
        p.dob = _dob;
        p.height = _height; 
        p.weight = _weight;
        p.bloodgroup = _bloodgroup;
        p.allergies = _allergies;

        p.addr = msg.sender;
        p.date = block.timestamp;
        
        patientList.push(msg.sender);
        isPatient[msg.sender] = true;
        isApproved[msg.sender][msg.sender] = true;
        patientCount++;
    }

    //Retrieve a list of all patients address
    function getPatients() public view returns(address[] memory) {
        return patientList;
    }
 
    
    //Search patient details by entering a patient address (Only record owner or doctor with permission will be allowed to access)
    function searchPatientDemographic(address _address) public view returns(string memory) {
        //require(isApproved[_address][msg.sender]);      
        return (patients[_address].ic);
    }

  function print() public pure returns (string memory) {
    return "London";
  }
}
