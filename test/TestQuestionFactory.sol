pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/QuestionFactory.sol";

contract TestQuestionFactory {
  QuestionFactory questionfactory = QuestionFactory(DeployedAddresses.QuestionFactory());

  function testUserCanMakeQuestion() public {
    uint returnedId = questionfactory.makeQuestion("first?");
    uint expected = 0;
    Assert.equal(returnedId, expected, "First question ID 0 should be recorded.");
  }

  function testUserCanMakeASecondQuestion() public {
    uint returnedId = questionfactory.makeQuestion("second?");
    uint expected = 1;
    Assert.equal(returnedId, expected, "Second question ID 1 should be recorded.");
  }
  
  function testQuestionOwner() public {
    var (text, returnedOwner) = questionfactory.getQuestion(0);
    Assert.equal(returnedOwner, this, "Question owners are the same.");
    //Assert.equal(bytes(text), bytes("first?"), "Question text is correct.");
  }

  function testUserCanGiveAnswer() public {
    uint returnedId = questionfactory.giveAnswer(1,"This is the second question");
    uint expected = 0;
    Assert.equal(returnedId, expected, "First answer ID 0 should be recorded.");
  }

  function testUserCanGiveASecondAnswer() public {
    uint returnedId = questionfactory.giveAnswer(1,"Yet another answer for the second question");
    uint expected = 1;
    Assert.equal(returnedId, expected, "Second answer ID 1 should be recorded.");
  }

  function testAnswerProperties() public {
    var (qId, text, returnedOwner) = questionfactory.getAnswer(0);
    Assert.equal(returnedOwner, this, "Question owners are the same.");
    Assert.equal(qId, 1, "Question id in Answer is correct.");
    //Assert.equal(bytes(text), bytes("This is the second question"), "Answer text is correct.");
  }

  //Following TESTS are NOT possible YET. Becasue of dynamic array returning and stuff.
  /*
  function testGetQuestionsByOwner() public {   
    uint8[] memory questions = questionfactory.getQuestionsByOwner(this);
    uint8[2] memory expected = [0,1];
    Assert.equal(questions, expected, "Test questions returned.");
  }

  function testGetQuestionAnswers() public {
  }
  */
}