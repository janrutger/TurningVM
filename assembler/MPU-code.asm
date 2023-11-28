# The job is returns f(n) = n * 2 to jobResults
@job
    RESULT 


ret

# gets a job from the jobQueue and start it
@worker
    RUN

ret


@main     # pushes the jobs to the jobQueue
    #    job instruction takes an pointer (From the stack) to a memory adres as input and gets an module to call

    #    PEEK adres from memory, (a value or array)
    #    make UID,
    #    append UID to local-pendingJobs
    #    append job (UID, MEMvalue, @job) to jobQueue (list, of lists)
        push 'args'
        job @job


    #    result instruction (for processing the return value(s))

    #    check if jobResults has values AND the first local-pendingJobs is in there
    #    if so: 
    #       get MEMvalue from local-pendingJobs 
    #       poke MEMvalue to (fixed) result adres
    #       sets stattus bit
    #    if not:
    #       unset status bit
        :loop
            result
            jupmt > call :do-something > jump :done
        jump :loop
        :done


       


ret


# a job
# [jobID, memVal, job]


# a resultValue
# {jobID : memVal}