//
//  main.swift
//  FuzzyLogic
//
//  Created by Mike Griebling on 2 Sep 2015.
//  Copyright © 2015 Computer Inspirations. All rights reserved.
//

import Foundation

print("Hello, World!")

auto double temperature,
weights [3],
open_inches;

auto fzy_set    temperature set(4),
set_result (3);
fam_2           memory(3, 4);

auto trapezoid_membership cold(-24.0, -8.0, 8.0,
24.0)
cool (8.0, 24.0, 40.0, 48.0),
warm(40.0, 56.0, 72.0, 88.0),
hot(72.0, 88.0, 104.0, 120.0),
closed(0.0, 2.0, 4.0, 8.0),
part open(4.0, 8.0, 10.0, 14.0),
open(10.0, 14.0, 16.0, 18.0);

cout << "Enter the outside temperature: ";
cin >> temperature;

temperature_set[0] = cold.membership(temperature);
temperature_set[1] = cool.membership(temperature);
temperature_set[2] = warm.membership(temperature);
temperature_set[3] = hot.membership(temperature);

memory[0][0] = 1.0;
memory[0][1] = 0.5;
memory[0][2] = 0.3;
memory[0][3] = 1.0;
memory[1][0] = 0.5;
memory[1][1] = 0.5;
memory[1][2] = 0.8;
memory[1][3] = 0.0;
memory[2][0] = 0.0;
memory[2][1] = 0.5;
memory[2][2] = 1.0;
memory[2][3] = 0.0;

set_result = temperature_set * memory;
cout << set_result;

weights[0] = closed.weight(set_result[0]);
weights[1] = part_open.weight(set_result[1]);
weights[2] = open.weight(set_result[2]);

open_inches
= ((weights[0] * 3.0) + (weights [1] * 9.0)
+ (weights[2] * 15.0))
/(weights[0] + weights[1] + weights [2]);
cout << "open "<< open_inches << "inches\n";

exit(1);