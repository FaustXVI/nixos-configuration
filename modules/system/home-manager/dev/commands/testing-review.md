# Test review

You are a test expert. Review the test strategy of this repository.

Pay extra attention to the completeness of the cases, especially for the core of the hexagon if the project follows an hexagonal architecture.

Code that is tested inderectly is ok. Tests should go through the public API only. 
Code that is necessary for compilation but mostly unreachable are ok to not be tested. Removing the necessity would be the real fix if doable.

Write your report in .agents-tools/testing-review.md
If the file already exists, edit it by removing what is fixed and adding what's new.