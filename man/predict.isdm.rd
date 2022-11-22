\name{predict.isdm}
\alias{predict.isdm}
\title{Makes predictions from an isdm object}
\description{ This function predicts from an isdm object from the \code{\link{isdm}} function.  It does so by sampling from the approximate posterior of the model and produces a posterior raster.}
\usage{
 \method{predict}{isdm}( object, covarRaster, S=500, intercept.terms=NULL, 
			n.threads=NULL, includeRandom=TRUE, includeFixed=TRUE, includeBias=FALSE, type="intensity", ...)
}
\arguments{
\item{object}{An object of class isdm, as obtained from \code{isdm}. No default.}
\item{covarRaster}{A rasterBrick (or rasterStack) object containing all the covariates in the distribution model.}
\item{S}{The number of posterior samples to take. Default is 500 samples, which is likely to be small for serious applications.}
\item{intercept.terms}{Vector of strings indicating which terms in the model should be included as intercepts. An example might be c("Intercept.AA","Intercept.AA:surveyIDdonna") meaning that the coefficient for Intercept.AA and for the interaction Intercept.AA:surveyIDdonna will both be added to each of the predictions. If NULL (default)_the function will choose one of (in this order or preference) Intercept.DC, Intercept.AA, Intercept.PA, Intercept.PO. It is easiest to take the text for the correct term from fit$mod$names.fixed.}
\item{n.threads}{How many threads to spread the computation over. Default is NULL, where the number used to estimate the model (arugment "fit") is used.}
\item{includeRandom}{Should the random spatial effect be included in the predictions? Default is TRUE, as it nearly always should be (unless you are trying to understand the contribution of the terms).}
\item{includeFixed}{Should the fixed effects, including the intercept(s), be included in the predictions? Default is TRUE, as it nearly always should be (unless you are trying to understand the contribution of the terms).}
\item{includeBias}{Should the sampling bias be included in the predictions? Default is FALSE, it is not included. This term is nearly always not-interesting in terms of figuring out what is where. However, it could be interesting to see where the search effort has been placed. Please be aware that includeBias=TRUE will force the intercept.PO to be added to the linear predictor. So, please do not include a non-NULL intercept.terms argument as that will make multiple intercepts to be included in the prediction.}
\item{type}{The type (scale) of prediction. Choices are "intensity" for the parameter of the log-Guass Cox process, "probability" for the probability of having any 1 observation in the prediction cell, or "link" for the linear predictor.}
\item{...}{Not implemented}
}

\details{ This function is a isdm specific interface to \code{INLA::inla.posterior.samples}. The function generates samples, selects which ones should be included for predicting and then performs the necessary machinations to do the predictions. All predictions are for the grid of covarRaster, including the area of each cell. That is the prediction is for the number of individuals (from the point process) within a cell.}

\value{A list containing the following elements:
\item{mean.field}{The predictions and summaries thereof. The summaries are for the cell-wise posterior: median, median, lower interval (2.5\%), upper interval (97.5\%), mean, and standard deviation. Note that the median it is possible that the median is a more robust measure of central tendancy than the mean.}
\item{cell.samples}{All the S posterior draws for each cell.}
\item{fixedSamples}{All the S posterior draws of the fixed effects.}
\item{fixed.names}{The names of the fixed effects in the samples, fixedSamples}
\item{predLocats}{The locations where the predictions are made}
}

\seealso{ \code{\link{makeMesh}}, \code{\link{inla.mesh.2d}}, \code{\link{inla}}, \code{INLA::inla.posterior.samples}}

\author{Scott D. Foster}
