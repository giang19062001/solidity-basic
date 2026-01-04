// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract SimpleStorage{
    int16  money = -500; // mặc định 0 có thể âm
    uint16 age = 25; // mặc định 0;  16 -> giá trị tối đa 2^16
    bool isPay = true; // mặc định false
    string name = 'Giang'; // mặc định ""

    // khi khai báo 1 state với 'Public' thì state đó sẽ tự tạo getter thay vì mình phải tự viết
    uint16[] public hobbieNumbers; 
    // uint16[5] public hobbieNumbers;   // !Khai báo mảng với length cố định

    // lưu dữ liệu nhị phân, dự liệu được hash
    bytes32 hashPassword = "a665a45920422f9d417e4867efdc4fb8"; // 32 -> 32 kí tự

    // lưu địa chỉ ví
    address mywallet = 0x76C9a0eEfA918d802D406B35D6b76e057a89b004;


    // mảng dữ liệu object
    struct Person{
        string name;
        uint256 age;
    }
    Person[] public personOnMyFamily;

    // state (key-value) -> 'mapping'  dữ liệu object
    mapping(address myAddress  => uint256 amount) public MyBlance; // -> key-value ( địa chỉ vs số )
    // mapping(address myAddress  => Person) public MyBlance;  // -> key-value ( địa chỉ vs struct)


    // hàm ghi dữ liệu state -> tốn phí gas
    function setMoney(int16 newMoney) public {
        money = newMoney; 
    }
    // view đánh dấu hàm này ko tốn phí gas khi gọi hàm này từ Off-chain
    // tốn phí gas khi có hàm khác gọi đến hàm này ở On-chain
    // ! view dùng đọc state (  đọc giá trị của các biến được khai báo ở trên  )
    function getMoney() view public returns(int16) {
        return money;
    }

    // pure cũng như view -> ko tốn phí gas
    // ! pure ko đọc state ( nếu đọc biến được khai báo ở trên sẽ lỗi, thường đọc biến từ tham số )
    function doubleMoney(int16 mon) pure public returns(int16) {
        return mon * 2;
    }

    // add giá trị vào 1 mảng số
    function addNewHobbieNumber(uint16 newNumber) public {
        hobbieNumbers.push(newNumber);
    }

    // string, array, struct, bytes những dữ liệu này khi là đối số thì nên thêm 'memory'
    // để tiết kiệm gas vì đây chỉ là dữ liệu đầu vào tạm thời -> khổng phải lưu vĩnh viễn
    function addNewPerson(string memory p_name, uint256  p_age ) public {
        personOnMyFamily.push(Person({name:p_name, age: p_age}));
    }

    //setMyBalance
    function setMyBalance(address m_Address, uint256 m_amount) public {
        MyBlance[m_Address] = m_amount;
    }

    // ! memory thì tham số trong hàm có thể thay đổi
    // function whatMemory(string memory p_name ) public {
    //     p_name = "hello";
    // }
    // ! calldata thì tham số trong hàm KHÔNG  thể thay đổi
    //  function whatMemory(string calldata p_name ) public {
    //     p_name = "hello";
    // }
}