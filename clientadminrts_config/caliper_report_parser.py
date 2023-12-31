from bs4 import BeautifulSoup
import subprocess
import wandb

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
def parse_caliper_log(episode_step):
    states = []
    #for key in keywords:
    command = f"cat /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt | grep '| common |' | tail -1"
    update_process = subprocess.Popen(
        [command],
        shell=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL,
    )
    command_read = f"cat /home/ubuntu/hll3_opennebula/caliper/blockreader-logs.txt | grep 'jfi' | tail -1"
    blockreader_process = subprocess.Popen(
        [command_read],
        shell=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL,
    )
        
    try:
        value, err = update_process.communicate()
        value = str(value)
        values = value.split('|')
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
        value_read, err_read = blockreader_process.communicate()
        value_read = str(value_read)
        values_read = value_read.split('=')
        print(f"BLOCK READER LOG EXTRACTED VALUE  {values_read}")
        jfi = float(values_read[1].strip())


        #if int(succ) == 0:
        #    rc = subprocess.call(["./scripts/caliper_kill.sh"])



        #Metrics are for the previous step - reward is based on this
        wandb.log({'success': succ}, step=episode_step)
        wandb.log({'fail': float(values[3].strip())}, step=episode_step)
        wandb.log({'send_rate': float(values[4].strip())}, step=episode_step)
        wandb.log({'avg_latency': float(values[7].strip())}, step=episode_step)
        wandb.log({'throughput': float(values[8].strip())}, step=episode_step)
        wandb.log({'successthroughput': successthroughput}, step=episode_step)
        wandb.log({'successrate': successrate}, step=episode_step)
        wandb.log({'relative_successthroughput': relative_successthroughput}, step=episode_step)
        wandb.log({'jfi': jfi}, step=episode_step)


        states.append({
            'name': values[1],
            'success': float(succ),
            'fail': float(values[3].strip()),
            'send_rate': float(values[4].strip()),
            'max_latency': float(values[5].strip()),
            'min_latency': float(values[6].strip()),
            'avg_latency': float(values[7].strip()),
            'throughput': float(values[8].strip()),
            'successthroughput': float(successthroughput),
            'successrate': float(successrate),
            'relative_successthroughput': float(relative_successthroughput),
            'jfi': float(jfi),
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