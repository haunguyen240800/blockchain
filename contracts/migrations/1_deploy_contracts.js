const Counters = artifacts.require("Counters");
const Voting = artifacts.require("Voting");

module.exports = function(deployer) {
  deployer.deploy(Counters);
  deployer.link(Counters, Voting);
  deployer.deploy(Voting);
};
