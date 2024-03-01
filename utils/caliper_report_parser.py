from bs4 import BeautifulSoup
import subprocess
import wandb
import time

# use this for HTML report generated by caliper
""" def parse_caliper_report(filename="fabric-test-network-extended/caliper/report.html"):
    with open(filename) as f:
        soup = BeautifulSoup(f, "html.parser")
    table = soup.find(id="benchmarksummary").table

    headers = [header.text for header in table.find_all("th")]
    contents = [
        {headers[i]: cell.text for i, cell in enumerate(row.find_all("td"))}
        for row in table.find_all("tr")
    ]
    # will return dict with table contents
    # TODO adjust this if necessary for your use case
    return contents[2:]  # skip header 0 and initial result """


# use this for LOG file generated by caliper
def parse_caliper_log(episode_step, current_throughput):
    states = []
    #for key in keywords:
    command = f"cat /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt | grep '| common |' | tail -1"
    update_process = subprocess.Popen(
        [command],
        shell=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL,
    )
        
    try:
        value, err = update_process.communicate()
        value = str(value)
        values = value.split('|')
        succtest = float(values[2].strip())
        #throughputtest = float(values[8].strip())
        if (episode_step % 100 == 0):
            throughputtest = current_throughput
        # while succtest == 0 or (throughputtest < (current_throughput/2)):
        #     print("SUCCESS IS ZERO OR TOO LOW")
        #     open("/home/ubuntu/hll3_opennebula/parser.txt", 'a').close()
        #     time.sleep(120)
        #     command = f"cat /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt | grep '| common |' | tail -1"
        #     update_process = subprocess.Popen(
        #         [command],
        #         shell=True,
        #         stdout=subprocess.PIPE,
        #         stderr=subprocess.DEVNULL,
        #     )
        #     value, err = update_process.communicate()
        #     value = str(value)
        #     values = value.split('|')
        #     succtest = float(values[2].strip())
        #     throughputtest = float(values[8].strip())


        if succtest == 0:
            ## Comment for 01 baselines only. Dont comment for 00 baselines and learn
            #rc = subprocess.call(["/home/ubuntu/hll3_opennebula/scripts/restart.sh"])
            print(f"LOG EXTRACTED VALUE {value}")
            succ = float(values[2].strip())
            duration = 0
            print(f"LOG DURATION {duration}")
            successthroughput = 0
            print(f"LOG SUCCESS THROUGHPUT {successthroughput}")
            successrate = 0
            relative_successthroughput = 0
            print(f"LOG SUCCESS RATE {successrate}")
            print(f"LOG RELATIVE SUCCESS THROUGHPUT {relative_successthroughput}")
            throughput = 0
            latency = 0
            max_latency = 0
            min_latency = 0
        else:
            throughput = float(values[8].strip())
            print(f"LOG EXTRACTED VALUE {value}")
            succ = float(values[2].strip())
            duration = (float(values[2].strip()) + float(values[3].strip())) / float(values[8].strip())
            print(f"LOG DURATION {duration}")
            successthroughput = float(values[2].strip()) / duration
            print(f"LOG SUCCESS THROUGHPUT {successthroughput}")
            successrate = (float(values[2].strip()) / (float(values[2].strip()) + float(values[3].strip()))) * 100
            relative_successthroughput = successthroughput / float(values[4].strip())
            print(f"LOG SUCCESS RATE {successrate}")
            print(f"LOG RELATIVE SUCCESS THROUGHPUT {relative_successthroughput}")
            latency = float(values[7].strip())
            max_latency = float(values[5].strip())
            min_latency = float(values[6].strip())

        #if int(succ) == 0:
        #    rc = subprocess.call(["./scripts/caliper_kill.sh"])



        #Metrics are for the previous step - reward is based on this
        wandb.log({'success': succ}, step=episode_step)
        wandb.log({'fail': float(values[3].strip())}, step=episode_step)
        wandb.log({'send_rate': float(values[4].strip())}, step=episode_step)
        wandb.log({'avg_latency': latency}, step=episode_step)
        wandb.log({'throughput': throughput}, step=episode_step)
        wandb.log({'successthroughput': successthroughput}, step=episode_step)
        wandb.log({'successrate': successrate}, step=episode_step)
        wandb.log({'relative_successthroughput': relative_successthroughput}, step=episode_step)


        states.append({
            'name': values[1],
            'success': float(succ),
            'fail': float(values[3].strip()),
            'send_rate': float(values[4].strip()),
            'max_latency': max_latency,
            'min_latency': min_latency,
            'avg_latency': latency,
            'throughput': float(throughput),
            'successthroughput': float(successthroughput),
            'successrate': float(successrate),
            'relative_successthroughput': float(relative_successthroughput),
        })
    except Exception as e:
        print(f"log parsing error {e}")
        states.append({
            'name': "common",
            'success': 0,
            'fail': 0,
            'send_rate': 0,
            'max_latency': 0,
            'min_latency': 0,
            'avg_latency': 0,
            'throughput': 0,
            'successthroughput': 0,
            'successrate': 0,
            'relative_successthroughput': 0,
        })    

    return states