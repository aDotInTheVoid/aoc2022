// See https://aka.ms/new-console-template for more information
string input = System.IO.File.ReadAllText("input.txt");

string[] elves = input.Split("\n\n");


long sumElf(string[] sums)
{
    long sum = 0;
    foreach (string s in sums)
    {
        if (s == "")
            continue;
        sum += Int64.Parse(s);
    }
    return sum;
}

long maxSum = elves.Select(x => sumElf(x.Split("\n"))).Max();

Console.WriteLine(maxSum);

var allCals = elves.Select(x => sumElf(x.Split("\n"))).ToList();
allCals.Sort();

var max3 = allCals.Skip(allCals.Count - 3).Sum();

Console.WriteLine(max3);