class_name StateMachine

var current_state: StateBase = null
var previous_state: StateBase = null

# Dictionary to store states (Type -> State)
var states: Dictionary = {}

# Initialize the state machine with a specific state type
func initialize(type_name: StringName) -> void:
    if states.has(type_name):
        current_state = states[type_name]
        current_state.on_enter()

# Initialize with a specific state instance
func initialize_with_state(state: StateBase) -> void:
    var state_type = state.get_class()
    if not states.has(state_type):
        states[state_type] = state

    current_state = states[state_type]
    current_state.on_enter()

# Add a state to the state machine
func add_state(state: StateBase) -> void:
    var state_type = state.get_class()
    states[state_type] = state

# Get a state by type
func get_state(type_name: StringName) -> StateBase:
    return states.get(type_name, null)

# Update the current state
func update(delta: float) -> void:
    if current_state:
        current_state.on_update(delta)

# Change to a state by type
func change_state(type_name: StringName) -> void:
    if not states.has(type_name):
        return
    
    previous_state = current_state
    current_state = states[type_name]
    if previous_state:
        previous_state.on_exit(current_state)  

    current_state.on_enter()

# Change to a specific state instance
func change_state_to_state(next_state: StateBase) -> void:
    previous_state = current_state
    current_state = next_state
    if previous_state:
        previous_state.on_exit(current_state)  
    current_state.on_enter()