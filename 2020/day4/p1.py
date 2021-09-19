with open("input", "r") as file:
    data = file.read().split("\n\n")
    
valid_records = 0
for record in data:
    rd = {d[0]: d[1] for d in [r.split(":") for r in record.split()]}
    try:
        assert "byr" in rd
        assert "iyr" in rd
        assert "eyr" in rd
        assert "hgt" in rd
        assert "hcl" in rd
        assert "ecl" in rd
        assert "pid" in rd
        valid_records += 1
    except:
        pass

print(valid_records)