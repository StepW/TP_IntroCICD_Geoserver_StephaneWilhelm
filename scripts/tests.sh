cd src/wms
# n'effectuera que les tests unitaires de base, et stopera le build si l'un d'entre eux échoue
mvn clean test
# test d'intégration
mvn integration-test
