var QuestionFactory = artifacts.require("./QuestionFactory.sol");
var SimpleStorage = artifacts.require("./SimpleStorage.sol");
var TutorialToken = artifacts.require("./TutorialToken.sol");
var ComplexStorage = artifacts.require("./ComplexStorage.sol");

module.exports = function(deployer) {
  deployer.deploy(QuestionFactory);
  deployer.deploy(SimpleStorage);
  deployer.deploy(TutorialToken);
  deployer.deploy(ComplexStorage);
};