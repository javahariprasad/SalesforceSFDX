public class CarBrandColors {
    
    public List<String> GetBrandNames(String Color){        
        Map<Brand,List<Colors>> mapOfBrandAndColors = storeBrandAndColors();
        List<String> listBrands = new List<String>();
        for(Brand b : mapOfBrandAndColors.KeySet()){
            for(Colors c :  mapOfBrandAndColors.get(b)){
                if(c.cName == Color){
                   listBrands.add(b.bName); 
                }
            }
        }
        return listBrands;        
    }
    
    private Map<Brand,List<Colors>> storeBrandAndColors(){
        
        //Brand Names
        Brand volksWagen = new Brand('Volkswagen');
        Brand mBenz = new Brand('Mercedez Benz');
        Brand honda = new Brand('Honda');
        
        //Color Names
        Colors blue =new Colors('Blue');
        Colors white =new Colors('White');
        Colors black =new Colors('Black');
        Colors grey =new Colors('Grey');
        Colors silver =new Colors('Silver');
        
        //Map to Brand and Colors
        return new Map<Brand,List<Colors>>{
                volksWagen => new List<Colors>{blue,white,black,grey},
                 mBenz=>    new List<Colors>{blue,black,silver,white},
                 honda =>   new List<Colors>{grey,black,silver,white} 
            };    
     } 
    
    public Class Brand{        
        String bName;
        public Brand(){}
        public Brand(String bName){this.bName = bName;}
    }
    
    public Class Colors{
        String cName;
        public Colors(){}
        public Colors(String cName){this.cName = cName;}
    }
}