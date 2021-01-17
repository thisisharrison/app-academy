import React from 'react';

class Calculator extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      result: 0,
      num1: '',
      num2: ''
    }
    this.setNum1 = this.setNum1.bind(this);
    this.setNum2 = this.setNum2.bind(this);
    this.add = this.add.bind(this);
    this.subtract = this.subtract.bind(this);
    this.multiply = this.multiply.bind(this);
    this.divide = this.divide.bind(this);
    this.reset = this.reset.bind(this);
  }

  setNum1(e) {
    const newNum1 = e.target.value;
    if (newNum1.length === 0) return;
    this.setState({ num1: parseInt(newNum1) });
  }

  setNum2(e) {
    const newNum2 = e.target.value;
    if (newNum2.length === 0) return;
    this.setState({ num2: parseInt(newNum2) });
  }

  add(e){
    e.preventDefault();
    this.setState({result: this.state.num1 + this.state.num2})
  }

  subtract(e){
    e.preventDefault();
    this.setState({result: this.state.num1 - this.state.num2})
  }

  multiply(e){
    e.preventDefault();
    this.setState({result: this.state.num1 * this.state.num2})
  }

  divide(e){
    e.preventDefault();
    this.setState({result: this.state.num1 / this.state.num2})
  }

  reset(e){
    e.preventDefault();
    this.setState({result: 0, num1: '', num2: ''})
  }


  render(){
    const {result, num1, num2} = this.state;
    return (
      <div>
        <h1>{result}</h1>
        <input type="text" onChange={this.setNum1} value={num1}/>
        <input type="text" onChange={this.setNum2} value={num2} />
        <button onClick={this.add}>➕</button>
        <button onClick={this.subtract}>➖</button>
        <button onClick={this.multiply}>✖️</button>
        <button onClick={this.divide}>➗</button>
        <button onClick={this.reset}>🔙</button>
      </div>
    );
  }
}

export default Calculator;
