pragma solidity ^0.5.0;

contract Marketplace {
    string public name;
    uint public productCount = 0;
    mapping(uint => Product) public products;

    struct Product {
        uint id;
        string name;
        uint price;
        address payable owner;
        bool purchased;
    }

    event ProductCreated(
        uint id,
        string name,
        uint price,
        address payable owner,
        bool purchased
);

    event ProductPurchased(
        uint id,
        string name,
        uint price,
        address payable owner,
        bool purchased
);

    constructor() public {
        name = "Dapp University Marketplace";
    }

    function createProduct(string memory _name, uint _price) public {
        //Require a name
        require(bytes(_name).length > 0);
        //Require a valid price
        require(_price > 0);
        //Increment product count
        productCount ++;
        //Create the
        products[productCount] = Product(productCount, _name, _price, msg.sender, false);
        //Trigger and event
        emit ProductCreated(productCount, _name, _price, msg.sender, false);
    }

    function purchaseProduct(uint _id) public payable{
        //Fetch the product
        Product memory _product = products[_id];
        //Fetch the owner
        address payable _seller = _product.owner;
        //Make sure the product is valid
        //Transfer ownership to the buyer
        _product.owner = msg.sender;
        //Mark as purchased
        _product.purchased = true;
        //Update product
        products[_id] = _product;
        //Pay seller with Ether
        address(_seller).transfer(msg.value);
        //Trigger an event
        emit ProductPurchased(productCount, _product.name, _product.price, msg.sender, false);
    }







}


