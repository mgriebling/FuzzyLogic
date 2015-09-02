//
//  Members.swift
//  FuzzyLogic
//
//  Created by Mike Griebling on 2 Sep 2015.
//  Copyright © 2015 Computer Inspirations. All rights reserved.
//

import Foundation

class membership_function
{
    public:
    virtual fuzzy membership(const double value)
    {
    return fuzzy(0.0);
    }
    virtual double weight(const fuzzy value)
    {
    return 0.0;
    }
};

class trapezoid_membership : public membership_function
{
    private:
    double   left_zero,
    left_ high,
    right_high,
    right_zero;
    public:
    trapezoid_membership(   const double,
    const double,
    const double,
    const double);
    void set(   const double left_zero_in,
    const double left_high_in,
    const double right_high_in,
    const double right_zero);
    void get(double *, double *, double *,
    double *) const;
    fuzzy membership(const double value) const;
    double weight(const weight);
};

trapezoid_membership::trapezoid_membership
const double left_zero_in = 0.0,
const double left_high_in  = 0.0,
const double right_high_in = 0.0,
const double right_zero_in = 0.0)
{
    left_zero = left_zero_in;
    left_high = left_high_in;
    right_high = right_high_in;
    right_zero = right_zero_in;
    if (left_high < left_zero)
    {
        left_high = left_zero;
    }
    if (right_high < left_high)
    {
        right_high = left_high;
    }
    if (right_zero < right_high)
    {
        right_zero = right_high;
    }
    return;
}

void trapezoid_membership::set(
const double left_zero_in = 0.0,
const double left_high_in = 0.0,
const double right_high_in = 0.0,
const double right_zero_in = 0.0)
{
    left_zero = left_zero_in;
    left_high = left_high_in;
    right_high = right_high_in;
    right_zero = right_zero_in;
    
    if (left_high < left_zero)
    {
        left_high = left_zero;
    }
    if (right_high < left_high)
    {
        right_high = left_high;
    }
    if (right_zero < right_high)
    {
        right_zero = right_high;
    }
    return;
}

void trapezoid_membership::get( double *left_zero_out,
double *left_high_out,
double *right_high_out,
double *right_zero_out) const
{
    *left_zero_out = left_zero;
    *left_high_out = left_high;
    *right_high_out = right_high;
    *right_zero_out = right_zero;
    
    return;
}

fuzzy trapezoid_membership::membership(
const double value) const
{
    auto fuzzy truth;
    
    if ((value <=left_zero) || (value >= right_zero))
    {
        truth = 0.0;
    }
    else
    {
        if ((value >= left_high)
            && (value <= right_high))
        {
            truth = 1.0;
        }
        else
        {
            if (value < left_high)
            {
                truth = (value - left_zero)
                    / (left_high - left_zero);
            }
            else
            {
                if (value = right_high)
                {
                    truth = 1.0
                        - ((value - right_high)
                            / (right_zero - right_high));
                }
            }
        }
    }
    return truth;
}

double trapezoid_membership::weight(const fuzzy value)
{
    auto double a,
    b,
    h,
    area,
    right_x,
    left_x;
    
    h = value.get();
    
    b = right_zero - left_zero;
    
    if (value == 1.0)
    {
        a = right_high - left_high;
        area = (a + b) / 2.0;
    }
    else
    {
        right_x = -h * (right_zero - right_high)
            + right_zero;
        
        left_x = h * (left_high - left_zero)
            + left_zero;
        a = fabs(right_x - left_x);
        area = (a + b) * h / 2.0;
    }
    return area;
}