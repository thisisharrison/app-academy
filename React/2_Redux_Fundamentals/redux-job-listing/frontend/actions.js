export const SWITCH_LOCATION = 'SWITCH_LOCATION';

// Action is POJO, type use constant
export const selectLocation = (city, jobs) => (
    {
        type: SWITCH_LOCATION,
        city,
        jobs
    }
);