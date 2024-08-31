pragma solidity ^0.8.0;

contract HealthRecord {
    struct Patient {
        string name;
        uint age;
        string gender;
    }

    struct ExtendedPatient {
        string name;
        string diagnosis;
        uint256 diagnosisTime; // Timestamp
        string doctor;
        string comments;
        bool isHidden;
    }

    mapping(address => Patient) public patientRecords;
    mapping(address => ExtendedPatient) public extendedPatients;

    event PatientRecordUpdated(address patientAddress);

    function createPatientRecord(address _patientAddress, string memory _name, uint _age, string memory _gender) public {
        patientRecords[_patientAddress] = Patient(_name, _age, _gender);
        emit PatientRecordUpdated(_patientAddress);
    }

    function updatePatientRecord(address _patientAddress, string memory _name, uint _age, string memory _gender) public {
        Patient storage patient = patientRecords[_patientAddress];
        patient.name = _name;
        patient.age = _age;
        patient.gender = _gender;
        emit PatientRecordUpdated(_patientAddress);
    }

    function getPatientRecord(address _patientAddress) public view returns (string memory, uint, string memory) {
        Patient storage patient = patientRecords[_patientAddress];
        return (patient.name, patient.age, patient.gender);
    }

    function addPatient(
        string memory _name,
        address _publicKey,
        string memory _diagnosis,
        uint256 _diagnosisTime,
        string memory _doctor,
        string memory _comments
    ) public {
        extendedPatients[_publicKey] = ExtendedPatient(
            _name,
            _diagnosis,
            _diagnosisTime,
            _doctor,
            _comments,
            false
        );
    }

    

    function getPatient(address _publicKey) public view returns (ExtendedPatient memory) {
        require(!extendedPatients[_publicKey].isHidden, "Records are hidden");
        return extendedPatients[_publicKey];
    }
}