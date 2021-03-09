contract Test
{
	enum RequestType {NewHome, EditHome}
	enum HomeStatus {active, inactive}


 	struct Ownership
    {
        string name;
        uint passSer;
        uint passNum;
        uint256 date;
        string phoneNumber;
    }

    struct Owner
    {
        string name;
        uint passSer;
        uint passNum;
        uint256 date;
        string phoneNumber;
    }
    
    struct Home
    {
        string homeAddress;
        fixed area;
        address owner;
        uint cost;
        HomeStatus status;
    }
    
    struct Request
    {
        int requestType;
        Home home;
        int result;
        address adr;
    }
    
    struct Employee
    {
        string name;
        string position;
        string phoneNumber;
    }
    

    mapping(address => Employee) private employees;
	mapping(address => Owner) private owners;
	//ket is request initiator
	mapping(address => Request) private requests;
	mapping(string => Home) private homes;
	mapping(string => Ownership[]) private ownerships;
	

    function AddHome(string memory _adr, uint _area, uint _cost) public {
        Home memory h;
        h.homeAddress = _adr;
        h.area = _area;
        h.cost = _cost;
        homes[_adr] = h;
    }
    function GetHome(string memory adr) public returns (uint _area, uint _cost){
        return (homes[adr].area, homes[adr].cost);
    }


}
