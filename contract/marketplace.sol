// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

interface IERC20Token {
    function transfer(address, uint256) external returns (bool);

    function approve(address, uint256) external returns (bool);

    function transferFrom(address, address, uint256) external returns (bool);

    function totalSupply() external view returns (uint256);

    function balanceOf(address) external view returns (uint256);

    function allowance(address, address) external view returns (uint256);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

contract MarketPlace {
    uint256 private productsLength = 0;
    address private cUsdTokenAddress =
        0x874069Fa1Eb16D44d622F2e0Ca25eeA172369bC1;

    struct Product {
        address payable owner;
        string name;
        string image;
        string description;
        uint256 price;
        uint256 sold;
        uint256 stock;
        bool isDiscounted;
    }

    mapping(uint256 => Product) private products;

    uint256 public discountAmount = 0.1 ether;

    // modifier to check if caller is the owner of product
    modifier onlyProductOwner(uint256 _index) {
        require(products[_index].owner == msg.sender, "Unauthorized");
        _;
    }

    /**
     * @dev allow users to create a product on the platform
     * @notice input data needs to contain only valid values
     */
    function writeProduct(
        string calldata _name,
        string calldata _image,
        string calldata _description,
        uint256 _price,
        uint256 _stock
    ) public {
        require(bytes(_name).length > 0, "Empty name");
        require(bytes(_image).length > 0, "Empty image");
        require(bytes(_description).length > 0, "Empty description");
        require(_price >= 1 ether, "Price needs to be at least one CUSD");
        uint256 _sold = 0;
        products[productsLength] = Product(
            payable(msg.sender),
            _name,
            _image,
            _description,
            _price,
            _sold,
            _stock,
            false
        );
        productsLength++;
    }

    function readProduct(
        uint256 _index
    )
        public
        view
        returns (
            address payable,
            string memory,
            string memory,
            string memory,
            uint256,
            uint256,
            uint256,
            bool
        )
    {
        return (
            products[_index].owner,
            products[_index].name,
            products[_index].image,
            products[_index].description,
            products[_index].price,
            products[_index].sold,
            products[_index].stock,
            products[_index].isDiscounted
        );
    }

    /**
     * @dev allow users to buy a product listed on the platform, awards Royalt points for every cUSD spent, and give 0.1 cUSD discount for every royaly points spent.
     * @param _amount is the number of products to buy
     * @notice Transaction will revert if there are not enough quantity of product in stock to fulfill the order
     */
    function buyProduct(uint256 _index, uint256 _amount) public payable {
        Product storage currentProduct = products[_index];

        // amount is checked to prevent unexpected scenarios such as totalAmount being initialised as zero
        // current stock amount needs to be able to fulfill the order's amount

        require(currentProduct.stock >= _amount, "Not enough in stock");
        require(
            currentProduct.owner != msg.sender,
            "You can't buy your products"
        );

        uint256 totalAmount = currentProduct.price * _amount;
        uint256 deductAmount = calculateDeductAmount(_index, _amount);
        totalAmount -= deductAmount;

        require(
            IERC20Token(cUsdTokenAddress).transferFrom(
                msg.sender,
                currentProduct.owner,
                totalAmount
            ),
            "Transfer failed."
        );

        uint256 newSoldAmount = currentProduct.sold + _amount;
        uint256 newStockAmount = currentProduct.stock - _amount;

        currentProduct.sold = newSoldAmount;
        currentProduct.stock = newStockAmount;
    }

    function getProductsLength() public view returns (uint256) {
        return (productsLength);
    }

    function switchDiscount(uint _index) public onlyProductOwner(_index){
        products[_index].isDiscounted = !products[_index].isDiscounted;
    }

    function deleteProduct(uint _index) public onlyProductOwner(_index){
        delete products[_index];
    }

    /**
     * @dev allow products' owners to update their stock value
     */
    function updateStock(
        uint256 _index,
        uint256 _stock
    ) public onlyProductOwner(_index) {
        require(_stock != 0, "Stock cant be 0");
        products[_index].stock = _stock;
    }

    /**
     * @dev allow products' owners to update the price of their products
     */
    function updatePrice(
        uint256 _index,
        uint256 _price
    ) public onlyProductOwner(_index) {
        require(_price != 0, "Price cant be 0");
        products[_index].price = _price;
    }

    /**
     * @notice calculates the amount that will deducted when buying a specific product
     */
    function calculateDeductAmount(
        uint256 _index,
        uint256 _amount
    ) public view returns (uint256) {
        require(_amount > 0, "You must buy at least one product");
        uint256 totalAmount = products[_index].price * _amount;
        if (products[_index].isDiscounted) {
            return (totalAmount * discountAmount) / 1 ether;
        } else {
            return (0);
        }
    }
}
