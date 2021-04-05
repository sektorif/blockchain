pragma experimental ABIEncoderV2;

contract Owned{
    address payable private owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    modifier OnlyOwner{
        require(
            msg.sender == owner,
            'Your are not the owner'
            );
        _;
    }
    
    function ChangeOwner(address payable newOwner) public OnlyOwner{
        owner = newOwner;
    }
    
    function GetOwner() public returns (address){
        return owner;
    }
}

contract ROSReestr is Owned
{
    enum RequestType {NewHome, EditHome}
    
    uint private price = 100 wei;
    
    struct Ownership
    {
        string homeAddress;
        address owner;
        uint p;
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
        uint area;
        uint cost;
    }
    
    struct Request
    {
        RequestType requestType;
        string homeAddress;
        uint area;
        uint cost;
        uint result;
        address adr;
        bool isProcessed;
    }
    
    struct Employee
    {
        string name;
        string position;
        string phoneNumber;
        bool isset;
    }
    
    mapping(address => Employee) private employees;
    mapping(address => Owner) private owners;
    //ket is request initiator
    mapping(address => Request) private requests;
    mapping(string => Home) private homes;
    mapping(string => Ownership[]) private ownerships;

    uint private amount;
    
    modifier OnlyEmployee 
    {
        require(
            employees[msg.sender].isset != false,
            'Your are not the owner'
            );
        _;
    }
    
    modifier Costs(uint value)
    {
        require(
            msg.value >= value,
            'Not enough funds'
            );
        _;
    }
    
    function AddHome(string memory _adr, uint _area, uint _cost) public 
    {
        Home memory h;
        h.homeAddress = _adr;
        h.area = _area;
        h.cost = _cost;
        homes[_adr] = h;
    }
    
    function GetHome(string memory adr) public returns (uint _area, uint _cost)
    {
        return (homes[adr].area, homes[adr].cost);
    }
    
    function AddEmployee(address empl, string memory _name, string memory _pos, string memory _phone) public OnlyOwner
    {
        Employee memory e;
        e.name = _name;
        e.position = _pos;
        e.phoneNumber = _phone;
        e.isset = true;
        employees[empl] = e;
    }
    
    function EditEmployee(address empl, string memory _name, string memory _pos, string memory _phone) public OnlyOwner
    {
        employees[empl].name = _name;
        employees[empl].position = _pos;
        employees[empl].phoneNumber = _phone;
    }
    
    function GetEmployee(address empl) public OnlyOwner returns (string memory _name, string memory _pos, string memory _phone)
    {
        return (employees[empl].name, employees[empl].position, employees[empl].phoneNumber);
    }
    
    function DeleteEmployee(address empl) public OnlyOwner returns (bool)
    {
        if (employees[empl].isset == true){
            delete employees[empl];
            return true;
        }
        return false;
    }
    
    function AddRequest(uint rType, string memory adr, uint area, uint cost, address newOwner) public Costs(price) payable returns (bool)
    {
        Request memory r;
        r.requestType = rType == 0? RequestType.NewHome: RequestType.EditHome;
        r.homeAddress = adr;
        r.area = area;
        r.cost = cost;
        r.result = 0;
        r.adr = rType==0?address(0):newOwner;
        r.isProcessed = false;
        requests[msg.sender] = r;
        requestInitiator.push(msg.sender);
        amount += msg.value;
        return true;
    }
    
    function GetRequest() public OnlyEmployee returns (uint[] memory, uint[] memory, string[] memory)
    {
        uint[] memory ids = new uint[](requestInitiator.length);
        uint[] memory types = new uint[](requestInitiator.length);
        string[] memory homeAddresses = new string[](requestInitiator.length);
        for(uint i=0;i!=requestInitiator.length;i++){
            ids[i] = i;
            types[i] = requests[requestInitiator[i]].requestType == RequestType.NewHome ? 0: 1;
            homeAddresses[i] = requests[requestInitiator[i]].homeAddress;
        }
        return (ids, types, homeAddresses);
    }
    
    function ProcessedRequest(address _requestInitiator) public OnlyOwner returns (bool)
    {
        
    }
    
    function EditCost(uint _price) public OnlyOwner
    {
        price = _price;
    }
    
    function GetCost() public returns (uint)
    {
        return price;
    }
    
}
