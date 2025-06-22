public class BuilderPatternExample {

  
    static class Computer {
        private String CPU;
        private String RAM;
        private String storage;

     
        private Computer(Builder builder) {
            this.CPU = builder.CPU;
            this.RAM = builder.RAM;
            this.storage = builder.storage;
        }

        public String getCPU() {
            return CPU;
        }

        public String getRAM() {
            return RAM;
        }

        public String getStorage() {
            return storage;
        }

        
        @Override
        public String toString() {
            return "[CPU=" + CPU + ", RAM=" + RAM + ", Storage=" + storage + "]";
        }

       
        public static class Builder {
            private String CPU;
            private String RAM;
            private String storage;

            public Builder setCPU(String CPU) {
                this.CPU = CPU;
                return this;
            }

            public Builder setRAM(String RAM) {
                this.RAM = RAM;
                return this;
            }

            public Builder setStorage(String storage) {
                this.storage = storage;
                return this;
            }

            public Computer build() {
                return new Computer(this);
            }
        }
    }

    
    public static void main(String[] args) {
        Computer gamingComputer = new Computer.Builder()
                .setCPU("Intel i9")
                .setRAM("32GB")
                .setStorage("1TB SSD")
                .build();

        Computer officeComputer = new Computer.Builder()
                .setCPU("Intel i5")
                .setRAM("16GB")
                .setStorage("512GB SSD")
                .build();

       
        System.out.println("Gaming Computer: " + gamingComputer);
        System.out.println("Office Computer: " + officeComputer);
    }
}
