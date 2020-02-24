# generation de l"application (cas wms)
cd src/wms
mvn clean install
# generation du site web statique de documentation
cd ../../doc/en
mvn 
mvn clean install
mvn process-resources
mvn compile
