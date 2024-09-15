% -----------------------------
% CAR DIAGNOSIS EXPERT SYSTEM
% -----------------------------
% This system diagnoses common car issues based on user responses to symptoms.
% Used facts to define symptoms and rules to match the symptoms to find potential car issues.
% -----------------------------

% -----------------------------
% FACTS: Defining the symptoms for each car issue
% -----------------------------
% Each fact links a car issue to one of its associated symptoms.

symptom(dead_battery, 'Car won\'t start').
symptom(dead_battery, 'Headlights dim or off').
symptom(dead_battery, 'Clicking noise when starting').

symptom(flat_tire, 'Car pulling to one side').
symptom(flat_tire, 'Tire pressure warning light on').
symptom(flat_tire, 'Visible tire damage').

symptom(engine_overheating, 'High temperature gauge').
symptom(engine_overheating, 'Steam from the hood').
symptom(engine_overheating, 'Engine overheating warning light').

symptom(brake_failure, 'Soft brake pedal').
symptom(brake_failure, 'Car not stopping properly').
symptom(brake_failure, 'Brake warning light on').

% -----------------------------
% RULES: Defining the diagnosis rules for each car issue
% -----------------------------

diagnose(dead_battery) :-
    ask('Is the car not starting?'),
    ask('Are the headlights dim or off?'),
    ask('Is there a clicking noise when starting?').

diagnose(flat_tire) :-
    ask('Is the car pulling to one side?'),
    ask('Is the tire pressure warning light on?'),
    ask('Is there visible tire damage?').

diagnose(engine_overheating) :-
    ask('Is the temperature gauge reading high?'),
    ask('Is there steam coming from the hood?'),
    ask('Is the engine overheating warning light on?').

diagnose(brake_failure) :-
    ask('Is the brake pedal soft?'),
    ask('Is the car not stopping properly?'),
    ask('Is the brake warning light on?').

% -----------------------------
% INTERACTIVE SYMPTOM CHECKER: Asking the questions
% -----------------------------
% The system asks the user y/n questions about the symptoms.
% If the response is invalid like 'test','10' etc, it re-asks the same question.

ask(Question) :-
    write(Question), nl,
    write('Please respond with y or n: '),
    read(Response),
    validate_response(Response, Question).  % Ensure the response is valid

% -----------------------------
% RESPONSE VALIDATION: Handling user responses
% -----------------------------
% This predicate ensures the user's response is either 'y' or 'n'.
% If it's invalid, the question is re-asked until a valid response is received.

validate_response(y, _) :- !.  % If the answer is 'y', succeed and move on
validate_response(n, _) :- !, fail.  % If the answer is 'n', fail the current diagnosis
validate_response(_, Question) :-  % If the input is invalid, ask again
    write('Invalid response. Please respond with y or n.'), nl,
    ask(Question).

% -----------------------------
% MAIN DIAGNOSIS FLOW
% -----------------------------

start_diagnosis :-
    (diagnose(dead_battery) -> write('Diagnosis: Dead Battery'), nl;
     diagnose(flat_tire) -> write('Diagnosis: Flat Tire'), nl;
     diagnose(engine_overheating) -> write('Diagnosis: Engine Overheating'), nl;
     diagnose(brake_failure) -> write('Diagnosis: Brake Failure'), nl),
    !.

% If no diagnosis is reached, inform the user
start_diagnosis :-
    write('Unable to diagnose the issue based on the provided symptoms.'), nl.

% -----------------------------
% ENTRY POINT: Running the Diagnosis System
% -----------------------------

run :-
    write('Welcome to the Car Diagnosis System!'), nl,
    start_diagnosis.
