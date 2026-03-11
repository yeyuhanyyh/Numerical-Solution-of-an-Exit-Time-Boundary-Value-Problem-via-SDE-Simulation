# Numerical Solution of an Exit-Time Boundary Value Problem

This repository contains a MATLAB implementation for numerically solving an exit-time boundary value problem via stochastic differential equation (SDE) simulation.

## Project Overview

We consider the boundary value problem
\[
b(x,y)\cdot \nabla u(x,y) + \frac{1}{2}\Delta u(x,y) = f(x,y), \qquad (x,y)\in B_1(0),
\]
with boundary condition
\[
u(x,y)=\frac{1}{2}, \qquad (x,y)\in \partial B_1(0),
\]
where
\[
b(x,y)=(x,y), \qquad f(x,y)=x^2+y^2+1.
\]

The exact solution is
\[
u(x,y)=\frac{x^2+y^2}{2}.
\]

The goal of this project is to approximate the solution using the probabilistic representation of the PDE, simulate the corresponding diffusion process with the Euler--Maruyama method, and study the convergence behavior of the numerical error.

## Method

The associated stochastic differential equation is
\[
dX_t = X_t\,dt + dW_t,
\]
where \(W_t\) is a two-dimensional standard Brownian motion. Let
\[
\tau_D = \inf\{t\ge 0 : X_t \notin B_1(0)\}
\]
denote the first exit time from the unit disk.

Using the Feynman--Kac representation, the solution can be written as
\[
u(x)=\mathbb{E}_x\left[\frac{1}{2}-\int_0^{\tau_D} f(X_s)\,ds\right].
\]

In this repository, the expectation is approximated by Monte Carlo simulation, and the diffusion process is discretized by the Euler--Maruyama scheme.

## Contents

- `main.m` — MATLAB code for Monte Carlo simulation, trajectory plotting, and error analysis.
- `report.pdf` — Final report for the project.
- `fig2.png`, `fig3.png`, `fig4.png` — Representative simulated trajectory plots.
- `README.md` — Project description.

## How to Run

1. Open MATLAB.
2. Make sure all project files are in the same folder.
3. Run
   ```matlab
   main
