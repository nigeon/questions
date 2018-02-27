pragma solidity ^0.4.20;

contract QuestionFactory{
  struct Question {
    string text;
  }

  struct Answer {
      string text;
  }
  
  Question[] public questions;
  Answer[] public answers;
  mapping (uint => address) public questionToOwner;
  mapping (address => uint) public ownerQuestionCount;
  mapping (uint => address) public answerToOwner;
  mapping (uint => uint) public answerToQuestion;
  mapping (uint => uint) public answerQuestionCount;
  uint[][] public questionToAnswers;

  /**
   * Make a question, providing the reward for the correct answer
   */
  function makeQuestion(string _text) public {
    uint id = questions.push(Question(_text)) -1;
    questionToOwner[id] = msg.sender;
    ownerQuestionCount[msg.sender]++;
    uint[] storage _answers;
    questionToAnswers.push(_answers);
  }

  /**
   * Gets the owner questions id's
   */
  function getQuestionsByOwner(address _owner) external view returns(uint[]) {
    uint[] memory _indexes = new uint[](ownerQuestionCount[_owner]);
    uint counter = 0;

    for (uint i = 0; i < questions.length; i++) {
      if (questionToOwner[i] == _owner) {
        _indexes[counter] = i;
        counter++;
      }
    }
    return _indexes;
  }
  
  function giveAnswer(uint _questionId, string _text) external returns(bool) {
      uint id = answers.push(Answer(_text)) -1;
      answerToOwner[id] = msg.sender;
      answerToQuestion[id] = _questionId;
      questionToAnswers[_questionId].push(id);
      answerQuestionCount[_questionId]++;
  }
  
  function getAnswersByQuestion(uint _questionId) external view returns(uint[]) {
    return questionToAnswers[_questionId];
  }
  
}