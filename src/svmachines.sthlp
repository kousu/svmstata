{smcl}
{* *! version 0.0.1  28may2015}{...}
{cmd:help svmachines}{right: ({browse "http://www.stata-journal.com/article.html?article=st0461":SJ16-4: st0461})}
{hline}

{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{cmd:svmachines} {hline 2}}Support vector machines{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 18 2}
{cmd:svmachines} {depvar} {indepvars} {ifin} [{cmd:,} {it:options}]

{p 8 16 2}
{cmd:svmachines} {indepvars} {ifin}{cmd:,} {cmdab:t:ype(}{helpb svmachines##one_class:one_class}{cmd:)} [{it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Model}
{synopt :{opt t:ype(type)}}type of model to fit: {opt svc}, {opt nu_svc}, {opt svr}, or {opt nu_svr}, or {opt one_class}; default is {cmd:type(svc)}{p_end}
{synopt :{opt k:ernel(kernel)}}SVM kernel function to use: {opt linear}, {opt poly}, {opt rbf}, {opt sigmoid}, or {opt precomputed}, default is {cmd:kernel(rbf)}{p_end}
{* XXX the division between 'tuning' and 'model' parameters is hazy; for example, you could in theory cross-validate to choose degree (and people do this with neural networks), or even to choose the kernel . hmmmmm}{...}

{syntab:Tuning}
{synopt :{opt c(#)}}for {cmd:type(svc)}, {cmd:type(svr)}, and {cmd:type(nu_svr)} SVMs, the weight on the margin of error; should be > 0; default is {cmd:c(1)}{p_end}
{synopt :{opt eps:ilon(#)}}for {cmd:type(svr)} SVMs, the margin of error that determines which observations will be support vectors; default is {cmd:eps(0.1)}{p_end}
{synopt :{opt nu(#)}}for {cmd:type(nu_svc)}, {cmd:type(one_class)}, and {cmd:type(nu_svr)} SVMs; tunes the proportion of expected support vectors; should be in (0, 1]; default is {cmd:nu(0.5)}{p_end}
{synopt :{opt g:amma(#)}}for {cmd:kernel(poly)}, {cmd:kernel(rbf)}, and {cmd:kernel(sigmoid)}, a scaling factor for the linear part of the kernel; default is {cmd:gamma(}1/[{it:#} {indepvars}]{cmd:)}{p_end}
{synopt :{opt coef0(#)}}for {cmd:kernel(poly)} and {cmd:kernel(sigmoid)}, a bias ("intercept") term for the linear part of the kernel; default is {cmd:coef0(0)}{p_end}
{synopt :{opt deg:ree(#)}}for {cmd:kernel(poly)}, the degree of the polynomial to use; default is {cmd:degree(3)}{p_end}
{synopt :{opt shrink:ing}}whether to use {help svmachines##shrinking:shrinkage} heuristics to improve the fit{p_end}

{syntab:Features}
{* {synopt :{opt norm:alize}}whether to {help svmachines##normalize:center and scale} the data. NOT IMPLEMENTED{p_end}}{...}
{synopt :{opt prob:ability}}whether to {help svmachines##probability:precompute} for {cmd:predict, probability} during estimation; only applicable to classification problems{p_end}
{synopt :{opt sv:(newvar)}}an indicator variable to generate to mark each row as a support vector or not{p_end}

{syntab:Performance}
{synopt :{opt tol:erance(#)}}stopping tolerance used to decide convergence; default is {cmd:epsilon(0.001)}{p_end}
{synopt :{opt v:erbose}}turn on {help svmachines##verbose:verbose mode}{p_end}
{synopt :{opt cache:_size(#)}}amount of RAM used to cache kernel values during fitting, in megabytes; default is {cmd:cache_size(100)}{p_end}
{synoptline}
{pstd}All variables must be numeric, including categorical variables.
If you have categories stored in strings, use {helpb encode} before {cmd:svmachines}.
{p_end}
INCLUDE help fvvarlist


{title:Syntax for predict after svmachines}

{p 8 16 2}
{cmd:predict} {newvar} {ifin} [{cmd:,} {it:options}]

{synoptset 15}{...}
{synopthdr}
{synoptline}
{synopt :{opt prob:ability}}estimate class probabilities for each observation; the fit must have been previously made with {opt probability}{p_end}
{synopt :{opt scores}}output the scores, sometimes called decision values, that measure each observation's distance to its hyperplane; incompatible with {opt probability}{p_end}
{synopt :{opt v:erbose}}turn on {help svmachines##verbose:verbose mode}{p_end}
{synoptline}


{marker description}{...}
{title:Description}

{pstd}
{cmd:svmachines} fits a support vector machine (SVM) model.  SVM is not one
but several variant models each based upon the principles of splitting
hyperplanes and the culling of unimportant observations.

{pstd}
The basic SVM idea is to find a linear boundary -- a hyperplane -- in
high-dimensional space.  For classification, this is a boundary between two
classes; for regression, it is a line {help svmachines##epsilon:near} which
points should be -- much like in {help regess:ordinary least squares}, while
simultaneously minimizing the number of observations required to distinguish
this hyperplane.  The unimportant observations are ignored after fitting,
which makes SVM very memory efficient.

{pstd}
Each observation can be thought of as a vector, so the support vectors are
those observations which the algorithm deems critical to the fit.

{pstd}
This package is a thin wrapper for the widely deployed {cmd:libsvm} 
({help svmachines##libsvm:Chang and Lin 2011}).  The thinness of this wrapper
is intentional.  It means work done under Stata SVM should be replicable with
other {cmd:libsvm} wrappers such as 
{browse "http://weka.wikispaces.com/LibSVM":{cmd:Weka}} or 
{browse "http://scikit-learn.org/stable/modules/svm.html":{cmd:sklearn}}.  As
a side effect, some of the options are unfortunately terse.

{pstd}
See the {cmd:libsvm} SVM tutorial 
({help svmachines##svmtutorial:Bennett and Campbell 2000}) for a gentle
introduction to the method.  If you find this manual confusing, refer to the
authoritative {cmd:libsvm} 
{browse "http://www.csie.ntu.edu.tw/~cjlin/libsvm/faq.html":FAQ}, 
{browse "https://github.com/cjlin1/libsvm/blob/master/README":README}, and
implementation article ({help svmachines##libsvm:Chang and Lin 2011}).  Then,
please write us with your suggestions for clarification.

{pstd}
Please also feel free to {help svmachines##authors:send us} any other feature
requests.

{marker installation}{...}
{title:Installation}

{pstd}
Because this is just a wrapper, {cmd:libsvm} must be installed to use this
package.  On Windows, {cmd:libsvm.dll} is bundled with the package, and you
can find it in your {helpb adopath} (try {cmd:findfile libsvm.dll} to verify
this).  On OS X, {cmd:libsvm} is available in both 
{browse "https://brew.sh":brew} and 
{browse "https://www.macports.org":macports}.  On Linux, search for
{cmd:libsvm} in your distribution's package manager.  You can also compile and
install {cmd:libsvm} from source, if you cannot find it in your package
manager or if you want the latest {cmd:libsvm}.  If you are having plugin load
errors, please {help svmachines##authors:contact the authors}: we want to make
the experience as smooth as possible for our users across as many platforms as
possible.


{marker options}{...}
{title:Options for svmachines}

{pstd}
{cmd:svmachines} fits an SVM model, fitting {depvar} to {indepvars} -- except
under {cmd:type(one_class)}, which only uses {indepvars}.

{pstd}
{cmd:libsvm} has several algorithms with a single entry point.  Because this
package is a thin wrapper, {cmd:svmachines} also has several algorithms with a
single entry point.  This means not all combinations of options are valid.
Usually, {cmd:libsvm} will give an error if you specify an invalid
combination, but sometimes, it ignores parameters without informing the user.
Further, among valid combinations, not all options and datasets give good
results.  Our goal is to have sane defaults, so the only choice you usually
need to make is what {helpb svmachines##type:type()} and 
{helpb svmachines##kernel:kernel()} to use.  However, there is no way to give
universal default parameters.

{pstd}
Rather than guessing at the 
{help svmachines##tuning_params:tuning parameters}, you should almost always
use cross-validated grid search to find them.  Which parameters you need to
tune depends on which model you pick; for example, for ({cmd:type(svc)},
{cmd:kernel(rbf)}), you only need to find ({cmd:c()}, {cmd:gamma()}).  You can
grid search on a subset of your full data -- so long as it is a representative
sample -- to quickly find approximations for the optimal parameters.  The
{cmd:libsvm} guide ({help svmachines##libsvmguide:Hsu, Chang, and Lin 2003})
explains this in-depth.

{* MODEL PARAMS: }{...}
{marker type}{...}
{phang}
{opt type(type)} specifies which SVM model to run.  {it:type} is case
insensitive.

{phang2}
{cmd:svc} and {cmd:nu_svc} perform classification.  {depvar} should be a
variable containing categories.  Multiclass classification is automatically
handled if necessary, using the
{browse "http://en.wikipedia.org/wiki/Multiclass_classification":class-against-class}
method.

{pmore2}
If you try to use floating-point values with classification, you will find
that they are truncated mercilessly to their integer parts, so you may need to
recode your categories before giving them to {cmd:svmachines}.  If you end up
with almost as many classes as observations, you have probably used a
continuous {depvar} and should use regression instead.{p_end}

{phang2}
{cmd:svr} and {cmd:nu_svr} perform regression.  {depvar} should be a variable
containing continuous values.  Rather than trying to find a hyperplane that
separates data as far as possible, these try to find a hyperplane to which
most data are as near as possible.  See the support vector regression tutorial
({help svmachines##svr_tutorial:Smola and Sch{c o:}lkopf 2004}) for more
details.{p_end}

{marker one_class}{...}
{phang2}
{cmd:one_class} separates outliers from the bulk of the data.  {cmd:one_class}
is a form of unsupervised learning.  It estimates the support of a
distribution by distinguishing "class" from "outlier", based only on the
features given to it.  Therefore, it does not take a {depvar}.  Its predictions
give 1 for "class" and -1 for "outlier".{p_end}

{pmore2}
Tip: You may use the same {varlist} as with the other types.  {cmd:one_class}
just then interprets your {depvar} as one of its {indepvars}, giving it more
information to work with.{p_end}

{pmore}
To learn about the {help svmachines##nu:nu} variants, see 
{help svmachines##nusvm:Chen, Lin, and Sch{c o:}lkopf's (2005)} nu SVM
tutorial.{p_end}

{phang}
{marker kernel}{...}
{opt kernel(kernel)} gives a kernel function to use.  {it:kernel} is case
insensitive.

{pmore}
Much like {helpb glm}, the 
{browse "https://en.wikipedia.org/wiki/Kernel_Method":kernel trick} extends
the linear SVM algorithm to be capable of fitting nonlinear data.  Kernels
bend a nonlinear space into a linear one by applying high-dimensional mapping.
Under high enough dimensions, any set of data looks close to linear.  See
{browse "https://www.youtube.com/watch?v=3liCbRZPrZA"} to visualize this
process.  The "trick" -- and the reason why the set of kernels is hardcoded --
is that for certain kernels, the fit can be done efficiently without actually
constructing the high-dimensional points, because the estimation only scores
coefficients u using the output of the kernel, not the output of the values
the kernel is, in theory, operating upon.{p_end}

{pmore}
Kernels available in this implementation are the following:{p_end}

{phang2}
{opt linear} is the dot product you are probably familiar with from 
{help regress:ordinary least squares}, u'*v.{p_end}

{phang2}
{opt poly} (gamma*u'*v + coef0)^degree extends the linear kernel with
wiggliness.{p_end}

{phang2}
{opt rbf} stands for radial basis functions and treats the coefficients as a
mean to smoothly approach in a ball, with the form exp(-gamma*|u-v|^2); this
kernel tends to be a good generalist option for nonlinear data.{p_end}

{phang2}
{opt sigmoid} is a kernel that bends the linear kernel to fit in -1 to 1 with
tanh(gamma*u'*v + coef0), similar to {help logistic} nonlinearity.{p_end}

{phang2}
{opt precomputed} assumes that {depvar} is actually a list of precomputed
kernel values.  With effort, you can use this to use custom kernels with your
data.{p_end}
{*  TODO: give a complete working example of using a custom kernel }{...}

{* TUNING PARAMS: }{...}
{marker tuning_params}{...}
{marker c}{...}
{phang}
{opt c(#)} weights (regularizes) the error term used in {cmd:type(svc)},
{cmd:type(svr)}, and {cmd:type(nu_svr)}.  Larger numbers allow less error, but
overlarge numbers will lead to underfitting.

{phang}
{marker epsilon}{...}
{opt epsilon(#)} is the margin of error allowed by {cmd:type(svr)}.  Larger
numbers make your fit more able to incorporate more observations but can lead
to underfitting.  Smaller numbers can lead to overfitting.

{phang}
{marker nu}{...}
{opt nu(#)} is used in the nu variants.  The nu variants are a
reparamaterization of regular SVM, which lets you directly tune the size of
the {cmd:svmachines} margin using {cmd:nu()}.  This lets you control
overfitting versus underfitting.  {cmd:nu()} is simultaneously bound on the
fraction of training errors and the fraction of support vectors.  Smaller
{cmd:nu()} means a smaller margin of error allowed -- so, a tighter fit -- but
more SVs required, and larger {cmd:nu()} means a larger margin of error
allowed and fewer SVs required.  See the nu SVM tutorial 
({help svmachines##nusvm:Chen, Lin, and Sch{c o:}lkopf's 2005}) for details.
{* ..wait... this doesn't make any sense. nu == 0.1 means there are at most 10% (training) errors and at least 10% are support vectors.}{...}
{*      nu = 0.9 means there are at most 90% errors and at least 90% SVs.   you should always choose 0, then, to get perfect prediction and zero memory usage}{...}

{phang}
{marker gamma}{...}
{opt gamma(#)} is used in the nonlinear {cmd:kernel(poly)}, {cmd:kernel(rbf)},
and {cmd:kernel(sigmoid)} kernels as a scaling factor for the linear part.
Larger numbers weigh the data more.

{phang}
{marker coef0}{...}
{opt coef0(#)} similarly is used in the nonlinear {cmd:kernel(poly)} and
{cmd:kernel(sigmoid)} kernels as a pseudointercept term.

{phang}
{marker degree}{...}
{opt degree(#)} selects the degree of the polynomial used by
{cmd:kernel(poly)}.  This literally controls the degree of freedom in the
{cmd:kernel(poly)} fit; setting this too low results in underfitting and
sometimes even nonconvergence (notice that at {cmd:degree(1)}, this is just
the {cmd:kernel(linear)} kernel).  Setting this too high will result in
overfitting.

{marker shrinking}{...}
{phang}
{opt shrinking} invokes the shrinkage heuristics, which can sometimes improve
the fit by trading bias for variance.

{* FEATURE PARAMS: }{...}
{* {marker normalize} }{...}
{* {phang} }{...}
{* {opt normalize} instructs the estimation to first center and scale the data }{...}
{* as SVM tends to be very sensitive to scaling issues. }{...}
{* This normalizes all data to [0,1] using min-max normalization, as suggested in the {help svmachines##libsvmguide:{cmd:libsvm} guide}. }{...}
{* Normalization creates temporary variables, so you may prefer to preprocess the data yourself -- destructively and in-place -- to save time on re-estimations and memory for variables, }{...}
{* especially if you are bumping up against your Stata system limits.  You may find {cmd:ssc install center} helpful }{...}
{marker probability}{...}
{phang}
{opt probability} enables the use of 
{helpb svmachines##predict_prob:predict, probability}.
This does {browse "https://en.wikipedia.org/wiki/Platt_scaling":Platt scaling},
which for each class against class precomputes a logistic regression tuned
with fivefold cross-validation.  Internally, {cmd:libsvm} shuffles the data
before cross-validation using the operating system random-number generator,
which is unrelated to {help set seed:Stata's random-number generator}.
Different runs will give different results.  Enabling this demands a great
deal of additional CPU and RAM.

{phang}
{marker sv}{...}
{opt sv(newvar)} records in the given variable a Boolean indicating whether
each observation was determined to be a support vector.  On systems with an
older {cmd:libsvm}, notably Ubuntu up through 16.04, this feature is not
supported.

{* PERFORMANCE PARAMS: }{...}
{marker tolerance}{...}
{phang}
{opt tolerance(#)} is the stopping tolerance used by the numerical optimizer.
You could widen this if you are finding convergence is slow, but be aware that
nonconvergence is usually a deeper problem.  You could also tighten this
if you have a powerful enough machine and want to get slightly more accurate
estimates.
 
{marker verbose}{...}
{phang} 
{opt verbose} enables output from the low-level {cmd:libsvm} code for the
duration of the operation.

{phang}
{marker cache_size}{...}
{opt cache_size(#)} controls a time-memory tradeoff during estimation.  Value
is how many megabytes of RAM to set aside for caching kernel values.
Generally, more is faster, at least until you run out of RAM or cause your
machine to start swapping.  On modern machines, a reasonable choice is
{cmd:cache_size(1024)}.


{marker predict}{...}
{title:Options for predict}

{pstd}
After training, you can ask {cmd:svmachines} to {cmd:predict} what the
category (classification) or outcome value (regression) should be for each
given observation.  Results are placed into {newvar}.  {it:newvar} must not
exist, so if you want to repredict, your choices are {cmd:drop} {it:newvar} or
pick a new name, for example, {cmd:predict} {it:newvar2}.{p_end}

{marker predict_prob}{...}
{phang}
{cmd:probability} requests (for classification ({cmd:type(svc)},
{cmd:type(nu_svc)}) problems), for each observation, the probability of it
being each class.  {newvar} is used as a stem for the new columns.  Both
probabilities are computed with Platt scaling.  When enabled, so are
predictions; this algorithm is not guaranteed to give the same results as
otherwise.  The results should be sensible either way, so if you are getting
inconsistent results between the two algorithms, investigate the 
{help svmachines##tuning_params:tuning} parameters.  This option is not valid
for other SVM types.{p_end}

{phang}
{marker scores}{...}
{opt scores} outputs the values that {cmd:svmachines} uses to decide on which
side of the hyperplane a particular observation falls.  {newvar} is used as a
stem for the new columns.  For {cmd:type(one_class)} and regressions, there is
only one score.  For classifications, there is one score for every pair of
classes (this is expensive: k classes means k(k-1)/2 new columns!), because
{cmd:libsvm} aggregates the basic binary-only {cmd:svmachines} algorithm into
a multiclass algorithm with the one-against-one technique.  This option is
incompatible with {opt probability} because, once trained, the Platt scaling
algorithm does not directly compute scores.

{phang}
{opt verbose}; see {helpb svmachines##verbose:svmachines, verbose}.

{pstd}
Prediction implicitly uses the same {indepvars} as during estimation, so be
careful about renaming or dropping variables.


{title:Remarks}

{pstd}
Memory limits: The cheaper versions of Stata allow fewer variables and smaller
matrices to be used.  As machine-learning problems typically are on very large
datasets, it is easy to inadvertently instruct this package to construct more
columns or larger matrices than you can afford.  If you overflow 
{helpb maxvar}, you will receive an error, the operation will fail, and the
dataset will be left untouched.  If you overflow {helpb matsize}, the matrix
that overflowed will be missing, but operation will otherwise succeed.

{pstd}
If Stata's memory limits are an impossible hurdle, your best option is to give
up on Stata and switch to {cmd:libsvm}'s companion {cmd:svm-train} program.
This will have been installed with the {cmd:libsvm} package if you used a
package manager, or you can get it {browse "http://www.csie.ntu.edu.tw/~cjlin/cgi-bin/libsvm.cgi?+http://www.csie.ntu.edu.tw/~cjlin/libsvm+zip":from its authors}; you can use {helpb svmlight:export_svmlight} to extract your
dataset for use with {cmd:svm-train}.


{marker examples}{...}
{title:Examples}

INCLUDE help svm_examples


{marker results}{...}
{title:Stored results}

{pstd}
{cmd:svmachines} stores the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{* Note: svm_model components left unexposed: }{...}
{*      - probA, probB, the coefficients used for predict, prob; these are not, by themselves, interesting }{...}
{*      - label, the "labels" of the classes (which are the integers {cmd:libsvm} casts out of the initial dataset; exported with strLabels to be used for labeling rho and sv_coef, but otherwise not directly interesting and}{...}
{*      - nSV, the number of SVs per class; this is only interesting for classifications, and it duplicates what you can get out of "tab `e(depvar)' SV" }{...}
{*      - free_sv, internal {cmd:libsvm} flag which is a hack to stretch svm_model to handle creation from both svm_train() and svm_import() }{...}
{*      }{...}
{*      - SV[] and sv_indices[] are exposed indirectly with the sv() option }{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_class)}}number of classes, in a classification problem; {cmd:2} in a regression problem{p_end}
{synopt:{cmd:e(N_SV)}}number of support vectors; if {cmd:e(N_SV)}/{cmd:e(N)} is close to 100%, your fit is inefficient; perhaps
you need to adjust your {helpb svmachines##kernel:kernel()}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:svmachines}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(model)}}{cmd:svmachines}{p_end}
{synopt:{cmd:e(svm_type)}}SVM-type string, as above{p_end}
{synopt:{cmd:e(svm_kernel)}}kernel string, as above{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(levels)}}list of the classes detected, in the order they were
detected; only defined for {cmd:type(svc)} and {cmd:type(nu_svc)}{p_end}
{* {synopt:{cmd:e(estat_cmd)}}program used to implement {cmd:estat}{p_end} }{...}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(sv_coef)}}coefficients of the support vectors for each fit hyperplane in the {bf:dual} quadratic programming problem{p_end}
{* TODO: is there a clearer explanation of sv_coef? Is it worth including? }{...}
{synopt:{cmd:e(rho)}}intercept term for each fit hyperplane; lower triangular and {cmd:e(N_class)}^2 large, with each entry [i,j] representing the hyperplane between class i and class j{p_end}


{marker copyright}{...}
{title:Copyright}

{pstd}
The wrapper is licensed:

{pmore}
The MIT License (MIT)

{pmore}
Except where otherwise noted in the code, Copyright (c) 2015
Nick Guenther <nguenthe@uwaterloo.ca>, Matthias Schonlau <schonlau@uwaterloo.ca>

{pmore}
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

{pmore}
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

{pmore}
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


{pstd}
{cmd:libsvm} is licensed:

{pmore}
Copyright (c) 2000-2014 Chih-Chung Chang and Chih-Jen Lin{break}
All rights reserved.

{pmore}
Redistribution and use in source and binary forms, with or without
modification, are permitted, provided that the following conditions are met:

{pmore}
1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

{pmore}
2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

{pmore}
3. Neither the names of copyright holders nor the names of its contributors
may be used to endorse or promote products derived from this software without
specific prior written permission.

{pmore}
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


{marker references}{...}
{title:References}

{marker svmtutorial}{...}
{phang}
Bennett, K. P., and C. Campbell. 2000.  Support vector machines: Hype or
hallelujah?  {it:SIGKDD Explorations} 2(2): 1-13.

{marker libsvm}{...}
{phang}
Chang, C.-C., and C.-J. Lin. 2011.
LIBSVM: A library for support vector machines.
{it:ACM Transactions on Intelligent Systems and Technology} 2(3): Article 27.

{marker nusvm}{...}
{phang}
Chen, P.-H., C.-J. Lin, and B. Sch{c o:}lkopf. 2005.
A tutorial on nu-support vector machines.
{it:Applied Stochastic Models in Business and Industry} 21: 111-136.

{marker sourcecode}{...}
{phang}
Guenther, N., and M. Schonlau. 2015.
Stata-SVM.
{browse "https://git.uwaterloo.ca/nguenthe/statasvm"}.

{marker libsvmguide}{...}
{phang}
Hsu, C.-W., C.-C. Chang, and C.-J. Lin. 2003. A practical guide to support
vector classification. {browse "http://www.csie.ntu.edu.tw/~cjlin/papers/guide/guide.pdf"}.

{marker svr_tutorial}{...}
{phang}
Smola, A. J., and B. Sch{c o:}lkopf. 2004.
A tutorial on support vector regression.
{it:Statistics and Computing} 14: 199-222.


{marker authors}{...}
{title:Authors}

{pstd}
Though the license does not obligate you in any way to do so, if you find this
software useful, we would be curious and appreciative to hear about your
adventures in machine learning with Stata.  Thank you.

{pstd}
You can contact us at

{pstd}Nick Guenther{break}
University of Waterloo{break}
Waterloo, Canada{break}
nguenthe@uwaterloo.ca

{pstd}Matthias Schonlau{break}
University of Waterloo{break}
Waterloo, Canada{break}
schonlau@uwaterloo.ca


{title:Also see}

{p 4 14 2}Article:  {it:Stata Journal}, volume 16, number 4: {browse "http://www.stata-journal.com/article.html?article=st0461":st0461}{p_end}

{p 7 14 2}
Help:  {manhelp regress R}{p_end}
