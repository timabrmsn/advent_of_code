with open("input", "r") as file:
    data = file.read().split("\n\n")

valid_records = 0
for record in data:
    rd = {d[0]: d[1] for d in [r.split(":") for r in record.split()]}
    try:
        assert 1920 <= int(rd["byr"]) <= 2002
        assert 2010 <= int(rd["iyr"]) <= 2020
        assert 2020 <= int(rd["eyr"]) <= 2030
        hgt = rd["hgt"]
        if "in" in hgt:
            assert 59 <= int(hgt.strip("in")) <= 76
        elif "cm" in hgt:
            assert 150 <= int(hgt.strip("cm")) <= 193
        else:
            raise Exception
        hcl = rd["hcl"]
        assert hcl.startswith("#")
        assert int(hcl.lstrip("#"), 16)
        assert rd["ecl"] in ("amb", "blu", "brn", "gry", "grn", "hzl", "oth")
        assert (rd["pid"].isnumeric() and (len(rd["pid"]) == 9))
        valid_records += 1
    except:
       pass

print(valid_records)