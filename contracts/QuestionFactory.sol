pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/math/SafeMath.sol';

contract QuestionFactory{
  using SafeMath for uint256;

  struct Question {
    string text;
    address owner;
    uint[] answers;
  }

  struct Answer {
    uint questionId;
    string text;
    address owner;
  }
  
  Question[] public questions;
  Answer[] public answers;

  mapping (address => uint) public ownerQuestionCount;

  /**
   * Make a question, providing the reward for the correct answer
   */
  function makeQuestion(string _text) public returns(uint) {
    Question memory _q = Question(_text, msg.sender, new uint[](0));
    uint id = questions.push(_q).sub(1);
    ownerQuestionCount[msg.sender] = ownerQuestionCount[msg.sender].add(1);

    return id;
  }

  /**
   * Gets the owner questions id's
   */
  function getQuestionsByOwner(address _owner) external view returns(uint[]) {
    uint[] memory _indexes = new uint[](ownerQuestionCount[_owner]);
    uint counter = 0;

    for (uint i = 0; i < questions.length; i++) {
      if (questions[i].owner == _owner) {
        _indexes[counter] = i;
        counter = counter.add(1);
      }
    }
    return _indexes;
  }
  
  /**
   * Provide an answer to an specific question
   */
  function giveAnswer(uint _questionId, string _text) external returns(uint) {
    uint _answerId = answers.push(Answer(_questionId, _text, msg.sender)).sub(1);
    questions[_questionId].answers.push(_answerId);

    return _answerId;
  }
  
  /**
   * Returns all answers to a question
   */
  function getAnswersByQuestion(uint _questionId) external view returns(uint[]) {
    return questions[_questionId].answers;
  }

  /**
   * Struct UnPacker
   * TODO: IS THIS ONLY NEEDED/USED IN THE SOLIDITY TESTS?
   */
  function getQuestion(uint _questionId) external view returns (string, address) {
    return (questions[_questionId].text, questions[_questionId].owner);
  }

  /**
   * Struct UnPacker
   * TODO: IS THIS ONLY NEEDED/USED IN THE SOLIDITY TESTS?
   */
  function getAnswer(uint _answerId) external view returns (uint, string, address) {
    return (answers[_answerId].questionId, answers[_answerId].text, answers[_answerId].owner);
  }

}