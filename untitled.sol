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
    
    Owner private owner;
    Home private home;
    Request private request;
    Employee private employee;

    mapping(address => Employee) private employees;
	mapping(address => Owner) private owners;
	//ket is request initiator
	mapping(address => Request) private requests;
	mapping(string => Home) private homes;
	mapping(string => Ownership[]) private ownerships;
	

	function AddHome (string _adr, fixed _area, int _cost) public {
		Home memory h;
		h.homeAddress = _adr;
		h.area = _area;
		h.cost = _cost;
		homes[_adr] = h
	}

	function GetHome (string adr) public returns (fixed _area, int _cost){
		return (homes[adr].area, homes[adr].cost);
	}

    function SetRequest(int _requestType, string _homeAddress, fixed _area, uint _cost,  ) public
    {
        
    }
    
    function Test1(string memory Message) public 
    {
        message = Message;
    }
    
    function SetMessage(string memory newMessage) public
    {
        message = newMessage;
    }
    
    function GetMessage() public returns (string memory)
    {
        return message;
    }
}