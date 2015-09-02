//
//  FAM.swift
//  FuzzyLogic
//
//  Created by Mike Griebling on 2 Sep 2015.
//  Copyright © 2015 Computer Inspirations. All rights reserved.
//

import Foundation

class fam_2
{
    private:
    int set_qty,
    set_len;
    fzy_set **fam_data;
    public:
    fam_2(const int, const int);
    inline ~fam_2(void);
    fam_2(const fam_2&);   // copy constructor
    fam_2& operator=(const fam_2&);  // assignment
    fzy_set& operator[](const int);
    fzy_set& operator[](const int) const;
    friend ostream& operator<<(ostream& os,
    fam_2& z);
    friend fzy_set operator*(const fzy_set &,
    const fam_2 &);
};

fam_2::fam_2(const int setqty = 1,
const int setlen = 1)
{
    if ((setqty < 1) || (setlen < 1))
    {
        cout << "fam dimensions less than 1: "
            << setqty << ' '
            << setlen << '\n';
    }
    else
    {
        set_qty = setqty;
        set_len = setlen;
        fam_data = new class fzy_set*[set_qty];
        // check for failure of new
        for (int i = 0; i < set_qty; i++)
        {
            fam_data[i] = new fzy_set(set_len);
        }
    }
    return;
}

inline fam_2::~fam_2(void)
{
    for (int i = 0; i < set_qty; i++)
    {
        delete fam_data[i];
    }
    delete[] fam_data;
    return;
}

fam_2::fam_2(const fam_2& fam_in)
{
    
    set_qty = fam_in.set_qty;
    set_len = fam_in.set_len;
    fam_data = new class fzy_set *[fam_in.set_qty];
    
    for (int i = 0; i < set_qty; i++)
    {
        fam_data[i] = new fzy_set(set_len);
        *(fam_data[i]) = fam_in[i];
    }
}

fam_2& fam_2::operator=(const fam_2& r_value)
{
    auto int i;
    
    if (this ! = &r_value)
    {
        for (i = 0; i < set_qty; i++)
        {
            delete fam_data[i];
        }
        delete[] fam_data;
        fam_data
            = new class fzy_set *[r_value.set_qty];
        for (i = 0; i < set_qty; i++)
        {
            fam_data[i] = new fzy_set(r_value.set_len);
            *fam_data[i] = r_value[i];
        }
    }
    return *this;
}

fzy_set& fam_2:: operator[](const int len)
{
    
    return ((len >= 0) && (len <= set_qty)) ?
        **(fam_data + len) : **(fam_data);
}

fzy_set& fam_2::operator[](const int len) const
{
    return ((len >= 0) && (len <= set_qty)) ?
        **(fam_data + len) : **(fam_data);
}

ostream& operator<<(ostream& os, fam_2& z)
{
    os<<"(";
    fzy_set **f = z.fam_data;
    int i = z.set_qty - 1;
    for (int i = 0; i < l; i++)
    {
        os << *f[i];
    }
    return os << *f[i] << ")\n";
}

fzy_set operator*(const fzy_set &fuzzy_set,
const fam_2 &fam)
{
    auto int set_ctr,
    fuzz_ctr;
    auto fzy_set tmp_set(fam.set_len),
    new_set (fam._set_qty);
    
    if (fuzzy_set.dimension == fam.set_len)
    {
        for (set_ctr = 0; set_ctr < fam.set_qty;
            set_ctr++)
        {
            for (fuzz_ctr = 0; fuzz_ctr < fam.set_len;
                fuzz_ctr++)
            {
                tmp_set [fuzz_ctr]
                    = fuzzy_set[fuzz_ctr]
                    & fam[set_ctr] [fuzz_ctr];
            }
            new_set[set_ctr] = fzy_set_max(tmp_set);
        }
    }
    return new_set;
}
