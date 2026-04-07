extends AttackBehavior
class_name MeleeAttack

func execute(user, weapon_data):
    print("Melee attack")


func handle_input(user, weapon_data, input_state):
    if input_state.just_pressed:
        execute(user, weapon_data)