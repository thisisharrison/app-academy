import React from 'react';
import StepListItemContainer from './step_list_item_container';
import StepForm from './step_form';

class StepList extends React.Component {
    render() {
        // Passed from step_list_container
        const { steps, receiveStep, todo_id } = this.props;
        const stepsList = steps.map((step, idx) => 
                <StepListItemContainer key={step.id}
                                    step={step}/>)
        return (
            <div>
                <h3>Steps</h3>
                <StepForm todo_id={todo_id} receiveStep={receiveStep}/>
                <ul>
                    {stepsList}
                </ul>
            </div>
        )
    }
}

export default StepList;