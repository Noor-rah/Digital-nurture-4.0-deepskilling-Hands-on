import java.util.HashMap;

class Product {
    private int productId;
    private String productName;
    private int quantity;
    private double price;

    public Product(int productId, String productName, int quantity, double price) {
        this.productId = productId;
        this.productName = productName;
        this.quantity = quantity;
        this.price = price;
    }

    public int getProductId() {
        return productId;
    }

    public String getProductName() {
        return productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Product ID: " + productId + ", Name: " + productName + ", Quantity: " + quantity + ", Price: $" + price;
    }
}

public class InventoryManagement {
    private HashMap<Integer, Product> inventory;

    public InventoryManagement() {
        inventory = new HashMap<>();
    }

    public void addProduct(Product product) {
        inventory.put(product.getProductId(), product);
    }

    public void updateProduct(int productId, int newQuantity, double newPrice) {
        Product product = inventory.get(productId);
        if (product != null) {
            product.setQuantity(newQuantity);
            product.setPrice(newPrice);
        } else {
            System.out.println("Product not found!");
        }
    }

    public void deleteProduct(int productId) {
        if (inventory.remove(productId) == null) {
            System.out.println("Product not found!");
        }
    }

    public void displayInventory() {
        for (Product product : inventory.values()) {
            System.out.println(product);
        }
    }

    public static void main(String[] args) {
        InventoryManagement inventoryManagement = new InventoryManagement();

        Product product1 = new Product(1, "Laptop", 10, 999.99);
        Product product2 = new Product(2, "Smartphone", 20, 499.99);

        inventoryManagement.addProduct(product1);
        inventoryManagement.addProduct(product2);

        System.out.println("Initial Inventory:");
        inventoryManagement.displayInventory();

        inventoryManagement.updateProduct(1, 8, 899.99);
        System.out.println("\nInventory after update:");
        inventoryManagement.displayInventory();

        inventoryManagement.deleteProduct(2);
        System.out.println("\nInventory after deletion:");
        inventoryManagement.displayInventory();
    }
}
