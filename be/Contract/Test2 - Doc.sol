pragma solidity ^0.8.0;

contract DoctorRecord {
    struct Doctor {
        string name;
        string specialization;
        uint experience;
        string hospital;
    }

    struct ExtendedDoctor {
        string name;
        string specialization;
        uint experience;
        string hospital;
        string bio;
        bool isVerified;
    }

    mapping(address => Doctor) public doctorRecords;
    mapping(address => ExtendedDoctor) public extendedDoctors;

    event DoctorRecordUpdated(address doctorAddress);

    function createDoctorRecord(address _doctorAddress, string memory _name, string memory _specialization, uint _experience, string memory _hospital) public {
        doctorRecords[_doctorAddress] = Doctor(_name, _specialization, _experience, _hospital);
        emit DoctorRecordUpdated(_doctorAddress);
    }

    function updateDoctorRecord(address _doctorAddress, string memory _name, string memory _specialization, uint _experience, string memory _hospital) public {
        Doctor storage doctor = doctorRecords[_doctorAddress];
        doctor.name = _name;
        doctor.specialization = _specialization;
        doctor.experience = _experience;
        doctor.hospital = _hospital;
        emit DoctorRecordUpdated(_doctorAddress);
    }

    function getDoctorRecord(address _doctorAddress) public view returns (string memory, string memory, uint, string memory) {
        Doctor storage doctor = doctorRecords[_doctorAddress];
        return (doctor.name, doctor.specialization, doctor.experience, doctor.hospital);
    }

    function addDoctor(
        string memory _name,
        address _publicKey,
        string memory _specialization,
        uint _experience,
        string memory _hospital,
        string memory _bio
    ) public {
        extendedDoctors[_publicKey] = ExtendedDoctor(
            _name,
            _specialization,
            _experience,
            _hospital,
            _bio,
            false
        );
    }

    function verifyDoctor(address _publicKey) public {
        extendedDoctors[_publicKey].isVerified = true;
    }

    function getDoctor(address _publicKey) public view returns (ExtendedDoctor memory) {
        require(extendedDoctors[_publicKey].isVerified, "Doctor is not verified");
        return extendedDoctors[_publicKey];
    }
}