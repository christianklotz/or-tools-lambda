# The code in this function is from the Running OR-Tools Programs Introduction
# at https://developers.google.com/optimization/introduction/run_programs.

import json
from ortools.linear_solver import pywraplp

def handle(event, context):
    solver = pywraplp.Solver('SolveSimpleSystem',
                             pywraplp.Solver.GLOP_LINEAR_PROGRAMMING)

    x = solver.NumVar(0, 1, 'x')
    y = solver.NumVar(0, 2, 'y')
    objective = solver.Objective()
    objective.SetCoefficient(x, 1)
    objective.SetCoefficient(y, 1)
    objective.SetMaximization()
    solver.Solve()

    res = {
        'x': x.solution_value(),
        'y': y.solution_value()
    }

    return json.dumps(res)
