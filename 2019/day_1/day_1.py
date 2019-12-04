#!/usr/bin/env python3


def fuel_given_mass(mass):
    return mass // 3 - 2

def rocket_equation(mass):
    total_fuel = 0
    incr_fuel = fuel_given_mass(mass)
    while incr_fuel:
        total_fuel += incr_fuel
        incr_fuel = max(0, fuel_given_mass(incr_fuel))
    return total_fuel


with open("input.txt", "r") as infile:
    module_masses = list(map(int, infile))


print("Part 1:", sum(map(fuel_given_mass, module_masses)))
print("Part 2:", sum(map(rocket_equation, module_masses)))
